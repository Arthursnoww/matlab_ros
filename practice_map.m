% === PRÁTICA 1A - CRIANDO MAPA DE OCUPAÇÃO ===
% Ler a imagem do mapa
image = imread("mapa.png");

% Converter para tons de cinza (caso não esteja)
grayimage = rgb2gray(image);

% Binarizar (tornar preto e branco)
bwimage = grayimage < 128;  % tudo abaixo de 128 (meio do 0-255) vira 1 (ocupado)

% Criar a grade de ocupação
resolucao = 50; % número de células por metro
grid = robotics.BinaryOccupancyGrid(bwimage, resolucao);

% Mostrar o mapa
figure
show(grid)
title("Occupancy Grid do Mapa")

[H,W] = size(bwimage);             % pixels (da sua imagem)
resolucao = 50;                    % células por metro (cells/m)
tam_m = [H W] / resolucao;         % tamanho do mapa em metros [Y X]
fprintf('Tamanho: %.2fm (Y) x %.2fm (X)\n', tam_m(1), tam_m(2));


% (A) PGM (0=preto, 255=branco). Para o padrão ROS, livre=0, ocupado=255:
pgm = uint8(~bwimage)*255;     % inverte para combinar com thresholds do YAML
pgm = flipud(pgm);             % origem no canto inferior-esquerdo
imwrite(pgm,'mapa.pgm','pgm');

% (B) YAML
meters_per_cell = 1/resolucao;
yaml = [
"image: mapa.pgm"
"resolution: " + string(meters_per_cell)
"origin: [0.0, 0.0, 0.0]"
"occupied_thresh: 0.65"
"free_thresh: 0.196"
"negate: 0"
];
fid = fopen('mapa.yaml','w'); fprintf(fid,'%s\n',yaml); fclose(fid);
disp('Gerados: mapa.pgm e mapa.yaml');
