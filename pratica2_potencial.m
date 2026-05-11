%% === PRÁTICA 2 - CAMPOS POTENCIAIS (NOVO MAPA) ===
clc; clear; close all;

%% 1) Carregar o novo mapa
resolucao = 50;
imagem = imread("mapa.png");   % novo arquivo
grayimg = rgb2gray(imagem);
binImage = grayimg < 128;           % binariza (preto=obstáculo)
grid = robotics.BinaryOccupancyGrid(binImage, resolucao);
show(grid); title("Binary Occupancy Grid (Novo Mapa)");

%% 2) Inflar o mapa (para representar o robô)
robotRadius = 0.177;
mapInflated = copy(grid);
inflate(mapInflated, robotRadius);
figure;
show(mapInflated); title("Mapa Inflado");

%% 3) Converter o mapa em matriz e criar campo de obstáculos
matriz = occupancyMatrix(mapInflated);
Watr = 15;                       % peso do obstáculo
matrix = flip(matriz * Watr);
figure;
surf(matrix); colormap('jet'); shading interp; colorbar;
title("Campo de Obstáculos");

%% 4) Criar malha de coordenadas automaticamente
[rows, cols] = size(matrix);
xf = linspace(0, cols/resolucao, cols);
yf = linspace(0, rows/resolucao, rows);
[X, Y] = meshgrid(xf, yf);

%% 5) Definir início e destino (ajuste manual conforme mapa novo)
startLoc = [0.5 0.5];     % canto inferior esquerdo
endLoc   = [8.0 6.5];     % canto superior direito

%% 6) Campo atrativo + repulsivo
KA = 15;
aux = sqrt((endLoc(1)-X).^2 + (endLoc(2)-Y).^2);
VG = KA * aux;
Temp = VG + matrix;
figure;
surf(xf, yf, Temp);
colormap('jet'); shading interp; colorbar;
title("Mapa Distorcido pelo Campo Potencial");

%% 7) Extrair obstáculos
[ox, oy] = size(matrix);
count = 1;
for y = 1:7:ox
    for x = 1:7:oy
        if matrix(y, x) == 15
            obstacles{count} = [x/resolucao, y/resolucao, robotRadius];
            count = count + 1;
        end
    end
end
count = count - 1;

%% 8) Plot do mapa com obstáculos e pontos
figure;
show(mapInflated); hold on;
plot(endLoc(1), endLoc(2), 'bo');
plot(startLoc(1), startLoc(2), 'bx');
for i = 1:count
    plot(obstacles{i}(1), obstacles{i}(2), 'ro');
end
title("Novo Mapa com Obstáculos e Pontos");

%% 9) Gerar trajetória
current{1} = startLoc;
cntpose = 1;
ka = 0.1; kr = 0.002; DO = 0.2;
dist = 1; gradX = 0; gradY = 0;

while dist >= 0.01
    gradX = 0; gradY = 0;
    for m = 1:count
        RobotObstacleDistance = sqrt((current{cntpose}(1)-obstacles{m}(1))^2 + ...
                                     (current{cntpose}(2)-obstacles{m}(2))^2) - obstacles{m}(3);
        if RobotObstacleDistance <= DO
            gradX = gradX + kr * (current{cntpose}(1)-obstacles{m}(1));
            gradY = gradY + kr * (current{cntpose}(2)-obstacles{m}(2));
        end
    end
    
    dist = sqrt((endLoc(1)-current{cntpose}(1))^2 + (endLoc(2)-current{cntpose}(2))^2);
    derivX = ka * (endLoc(1)-current{cntpose}(1)) / dist;
    derivY = ka * (endLoc(2)-current{cntpose}(2)) / dist;
    
    current{cntpose+1}(1) = current{cntpose}(1) + (derivX + gradX);
    current{cntpose+1}(2) = current{cntpose}(2) + (derivY + gradY);
    
    plot(current{cntpose}(1), current{cntpose}(2), 'go');
    hold on;
    
    if dist <= 0.1
        break;
    end
    cntpose = cntpose + 1;
end
title("Trajetória por Campos Potenciais (Novo Mapa)");


% mapa_novo.pgm + mapa_novo.yaml
img = imread('mapa.png');
bw = rgb2gray(img) < 128;
imwrite(uint8(~bw)*255, 'mapa_novo.pgm', 'pgm');

resolucao = 50; % 50 células/m → 0.02 m/célula
meters_per_cell = 1/resolucao;

yaml = [
"image: mapa_novo.pgm"
"resolution: " + string(meters_per_cell)
"origin: [0.0, 0.0, 0.0]"
"occupied_thresh: 0.65"
"free_thresh: 0.196"
"negate: 0"
];
fid = fopen('mapa_novo.yaml','w'); fprintf(fid,'%s\n',yaml); fclose(fid);
