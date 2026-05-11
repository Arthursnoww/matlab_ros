# Planejamento de Trajetória e Mapas de Ocupação em MATLAB

Este repositório contém práticas desenvolvidas em MATLAB voltadas para:

- Criação de mapas de ocupação
- Conversão de mapas para o formato ROS
- Planejamento de trajetória
- Navegação robótica
- Campos potenciais artificiais
- Desvio de obstáculos

Os experimentos utilizam ferramentas da Robotics System Toolbox para simulação de navegação autônoma em ambientes bidimensionais.

---

# Conteúdo do Repositório

## 1. Criação de Mapa de Ocupação

Nesta prática é realizada a conversão de uma imagem de ambiente para um **Occupancy Grid Map**.

### Objetivo

Transformar um mapa em imagem em uma representação utilizada por sistemas robóticos para navegação.

### Etapas realizadas

- Leitura da imagem do mapa
- Conversão para escala de cinza
- Binarização do ambiente
- Criação do `BinaryOccupancyGrid`
- Visualização do mapa

### Conceitos abordados

- Occupancy Grid Mapping
- Representação espacial
- Ambientes binários
- Navegação robótica

### Resultado

- Geração do mapa de ocupação
- Visualização gráfica do ambiente
- Cálculo das dimensões reais do mapa

---

## 2. Exportação de Mapas para ROS

Conversão automática do mapa para o formato utilizado no ROS (Robot Operating System).

### Arquivos gerados

- `mapa.pgm`
- `mapa.yaml`

### Objetivo

Permitir integração do ambiente criado no MATLAB com sistemas robóticos baseados em ROS.

### Conceitos abordados

- ROS Map Server
- Formato PGM
- Arquivos YAML
- Sistemas robóticos integrados

---

## 3. Planejamento de Trajetória com Campos Potenciais

Simulação de navegação utilizando **Artificial Potential Fields (APF)**.

### Objetivo

Planejar uma trajetória entre um ponto inicial e um destino evitando colisões com obstáculos.

### Funcionamento

O algoritmo combina:

- Campo atrativo → puxa o robô para o objetivo
- Campo repulsivo → afasta o robô dos obstáculos

### Etapas da prática

1. Carregamento do mapa
2. Inflação dos obstáculos
3. Criação do campo repulsivo
4. Definição do ponto inicial e destino
5. Geração da trajetória
6. Navegação iterativa até o alvo

### Conceitos abordados

- Planejamento de trajetória
- Navegação autônoma
- Campos potenciais artificiais
- Desvio de obstáculos
- Robótica móvel

### Resultado

- Geração automática da trajetória
- Desvio seguro de obstáculos
- Visualização do caminho percorrido

---

## 4. Inflação de Obstáculos

Os obstáculos do ambiente são inflados para representar o tamanho físico do robô.

### Objetivo

Garantir que a trajetória planejada seja segura e considere as dimensões reais do robô.

### Conceitos abordados

- Safety margin
- Collision avoidance
- Modelagem geométrica

### Resultado

- Mapa inflado para navegação segura

---

## 5. Visualização dos Campos Potenciais

Geração de superfícies 3D representando:

- Campo atrativo
- Campo repulsivo
- Campo potencial resultante

### Objetivo

Visualizar matematicamente o comportamento do algoritmo de navegação.

### Conceitos abordados

- Funções potenciais
- Gradientes
- Otimização local
- Navegação baseada em potenciais

### Resultado

- Superfícies 3D do ambiente
- Mapa distorcido pelo campo potencial

---

# Tecnologias Utilizadas

- MATLAB
- Robotics System Toolbox
- Planejamento de trajetória
- Robótica móvel
- Campos potenciais artificiais
- Occupancy Grid Mapping

---


# Como Executar

## 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/Robot-Path-Planning.git
```

---

## 2. Abra o MATLAB

Certifique-se de possuir a:

- Robotics System Toolbox

instalada.

---

## 3. Execute os scripts

### Criar Occupancy Grid

```matlab
run('occupancy_grid.m')
```

### Planejamento com Campos Potenciais

```matlab
run('campos_potenciais.m')
```

---

# Objetivos Educacionais

Este projeto foi desenvolvido para auxiliar no aprendizado de:

- Robótica móvel
- Planejamento de trajetória
- Navegação autônoma
- ROS
- Campos potenciais artificiais
- Representação espacial de ambientes
- Desvio de obstáculos

---

# Resultados Esperados

- Conversão de mapas para Occupancy Grid
- Integração com ROS
- Planejamento automático de trajetórias
- Navegação evitando obstáculos
- Visualização matemática dos campos potenciais

---

# Autor

Projeto desenvolvido para fins acadêmicos e educacionais.
