#set page(paper: "a4", margin: 2.5cm) // Configurações globais
#set text(font: "Libertinus Serif", size: 12pt) 
#set heading(numbering: "1.1") // Isso numera as seções (1, 1.1, etc.)
#show link: it => box(
  stroke: green + 1pt, // Define a borda verde de 1pt
  radius: 0pt,         // Arredonda levemente os cantos (opcional)
  inset: 0pt,          // Espaçamento entre o texto e a borda
  it                   // O conteúdo do link 
)
#show ref: it => box(
  stroke: orange + 1pt, // Define a borda verde de 1pt
  radius: 0pt,         // Arredonda levemente os cantos (opcional)
  inset: 0pt,          // Espaçamento entre o texto e a borda
  it                   // O conteúdo do link 
)
#set bibliography(title: "Referências", style: "ieee") // Define
#show figure.where(kind: image): set figure(supplement: [Figura])

// --- Capa ---
#align(center)[
  #v(2cm) // Espaço no topo
  
  #text(size: 24pt, weight: "bold")[Projeto de Fonte de Corrente Contínua Ajustável]
  
  #v(1cm)
  
  #text(size: 14pt, style: "italic")[Disciplina: SSC0180 - Eletrônica para Computação]
  
  #v(2cm)
  
  // Lista de Autores
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 10pt,
    [
      *Ariel Alves da Silva* \
      8847378 \
    ],
    [
      *Nome do Autor 2* \
      NUSP B \
    ],
    [
      *Nome do Autor 3* \
      NUSP B \
    ]
  )
  #grid(
    columns: (1fr, 1fr),
    gutter: 10pt,
    [
      *Nome do Autor 1* \
      NUSP A \
    ],
    [
      *Nome do Autor 2* \
      NUSP B \
    ]
  )
  
  #v(4cm)
  
  // Data e Local
  #text(size: 12pt)[São Carlos, SP \ 2026]
]

#pagebreak() // Quebra para começar o conteúdo na página seguinte
// --- Fim da Capa ---

#outline(title: "Sumário")

#pagebreak()

= Introdução

O projeto consiste em elaborar um circuito que seja capaz de converter 110-220 V nominais provenientes de uma rede elétrica comum de corrente alternada (AC) em um sinal contínuo (DC) ajustável entre 3V e 12V.

Para isso, serão utilizados componentes simples e de baixo custo.

= Projeto de Fonte

O diagrama do projeto da fonte foi elaborado no simulador de circuito #link("https://www.falstad.com/circuit/circuitjs.html")[Falstad].

#figure(
  image("./images/diagram.png", width: 100%),
  caption: [Diagrama do Circuito de Fonte.],
)

Vamos explorar o que cada parte do circuito faz.

== Fonte de tensão AC

O elemento de fonte de tensão AC representa a tensão proveniente da rede elétrica. No Brasil, a frequência da rede elétrica é definida por padrão em 60Hz.

#figure(
  image("./images/font.png", width: 20%),
  caption: [Representação da fonte AC no Falstad.],
)

A forma de onda da tensão AC é uma senoidal simples, com período $T=1/(60"Hz")approx 17 "ms"$.

#figure(
  image("./images/font-signal.png", width: 100%),
  caption: [Tensão (V) da fonte em função do tempo.],
)

Na @fig:font-signal-period, é possível visualizar que o período da onda de 60Hz é de realmente 17 ms (o resultado não foi preciso por conta da falha em colocar a posição do cursor exata no pico da onda).

#figure(
  image("./images/font-signal-period.png", width: 50%),
  caption: [Tensão (V) da fonte em função do tempo.],
)<fig:font-signal-period>

É importante notar que estamos utilizando uma fonte "incomum" de 180V no circuito. Porém, na rede elétrica nacional, os rótulos 127V/220V repreentam o _Root Mean Square_, um valor de tensão que, caso fosse constante (CC) *produziria a mesma potência dissipada em uma carga resistiva do que os 180V oscilantes*.

A relação entre $V_"max"$ e $V_"rms"$ é dada por:

$ V_"max"=V_"rms"*sqrt(2) $

Isso é importante, pois mostra que devemos nos preocupar com a tensão máxima de 180V no cálculo dos componentes do circuito.

== Transformador

O transformador é responsável por converter uma tensão de entrada $V_1$ em outra tensão de saída $V_2$, que pode ser maior ou menor, dependendo na relação do número de espiras na entrada e na saída.

#figure(
  image("./images/transformer.png", height: 20%),
  caption: [Representação do transformador no Falstad.],
)

O funcionamento do transformador é graças à Lei de Faraday@helerbrock: Em uma bobina com $N_1$ espiras e tensão $V_1$, a corrente circulante nas espiras gera um campo magnético. Esse campo induz uma força eletromotriz na segunda bobina com $N_2$ espiras, de modo que a relação entre a força eletromotriz de entrada $V_1$ e de saída $V_2$ é dada por:

$ V_1 / V_2 = N_1 / N_2 $

== Ponte de diodos

A ponte de diodos é responsável por transformar um sinal de corrente alternada (AC) em sinal contínuo (DC). Quando a polaridade da fonte AC inverte, a ponte de diodos é feita de forma que o único caminho possível, na direção $+ arrow -$, seja no sentido horário.

#figure(
  image("./images/diode-1.png", width: 80%),
  caption: [Caminho da corrente na ponte de diodos.],
)
#figure(
  image("./images/diode-2.png", width: 80%),
  caption: [Caminho da corrente na ponte de diodos (fonte invertida).],
)

Cada diodo, apesar de sua utilidade, provoca uma queda de tensão fixa. Abaixo dessa tensão, ele para de conduzir.

- *Diodos de Silício*: Queda de cerca de 0,7 V.
- *Diodos de Germânio*: Queda de aproximadamente 0,2 V ou 0,3 V.

A ponte de diodos, além da queda de tensão, faz com que a parte do sinal que antes era negativa fique espelhada (positiva). Isso nos fornece um sinal estritamente positivo, com frequência duplicada (2$f$).

#figure(
  image("./images/diode-filter.png", width: 80%),
  caption: [Sinal filtrado pela ponte de diodos],
)

O sinal que antes possuía $T approx 17 "ms"$ agora possui $ T approx 17/2 = 8.5 "ms"$, indicando que a frequência dobrou.

== Capacitor + Resistência (Circuito RC)

O capacitor armazena carga elétrica e fornece tensão para o circuito quando:

$ V(t)_"fonte" < Q(t)/C $

De modo que C = Capacitância (constante), medida em Faraday (F).

O capacitor é um componente dinâmico, e possui 4 comportamentos diferentes:

- Capacitor *descarregado* ($V_"fonte"  != 0$, $V_c = 0$): Age como um curto-circuito. Sem uma resistência em série, a corrente no carregamento inicial do capacitor é altíssima ($I = V / R$, com $R << V$, com $R = R_"fonte" + R_"fio" << 180V$).

- Capacitor *carregando* ($V_"fonte" > V_c$): Conforme carrega, o capacitor ganha tensão (carga). Isso reduz a d.d.p. sobre o resistor ($V_r = V_"fonte" - V_c$). Como $I_r=V_r / R$, conforme o capacitor carrega, a corrente que passa pelo trecho diminui.

- Capacitor *carregado* ($V_"fonte" = V_c$): Age como um terminal aberto, pois atinge um equilíbrio de carga de modo que $V_c = V_"fonte"$. Sem diferença de pontencial, não há corrente no trecho.

- Capacitor *descarregando* ($V_"fonte" < V_c$): Fornece tensão para os seus terminais, de modo que a d.d.p. começa a aumentar novamente e a corrente que passa por ele aumenta. Porém, conforme descarrega, chega um momento em que $V_"fonte" = V_c$ e a corrente para de passar novamente.

O capacitor não sofre com o surto de corrente inicial, mas pode sobrecarregar outros compontentes. O único ponto a se prestar atenção para o capacitor é a tensão máxima que ele suporta.

== LED + Resistor

O LED apenas serve para indicar se a fonte está ligada e com corrente fluindo. O Resistor evita que o LED queime.

== Diodo Zener

O diodo Zener funciona como uma válvula de escape quando polarizado reversamente. Se conectado de forma direta, ele conduz como um diodo de silício comum (queda de ≈ 0.7V). Nesse projeto, vamos utilizar um diodo Zener de 13V.

Quando a tensão está abaixo de 13V, a tensão nos seus terminais é igual à tensão da fonte. Em uma tensão muito baixa, o Zenner simplesmente impede a passagem de corrente (assim como um diodo de germânio comum abaixo de 0.7V, por exemplo).

Acima de 13V, o Zenner trava a tensão em seus terminais em 13V. E a corrente excedente começa a fluir pelo Zenner. Assim, se temos uma tensão oscilando entre 15V e 20V, por exemplo, o Zenner garante os 13V estáveis. É como uma torneira em uma caixa d'água balançando: A torneira sempre abaixo da oscilação garante um fluxo constante.

== Potenciômetro + R2

Servem como divisor de tensão. Se o Zenner fornece 13V, o potenciômetro com R2 oferecem ao usuário escolher entre 13V e uma tensão menor ajustável.

== Transistor NPN

O transistor mantém a tensão da base que produzimos com o Zenner no emissor, com uma pequena queda. A vantagem de usar o transistor é que a corrente que vai para a carga não vai passar pelo Zenner + Potenciômetro + Resistores, sobrecarregando eles. A corrente vem direto da ponte de diodos.

Essa é a definição principal de um "Transistor de Passagem em Série": amplificar a corrente enquanto mantém a tensão espelhada, isolando a malha de controle sensível da malha de potência pesada.

= Resolvendo circuito

Antes de resolver o circuito, precisamos saber o que queremos: Uma tensão de corrente contínua DC de saída com regulagem entre 3V e 12V.

Agora temos que levar algumas fórmulas em consideração.

1. *Tensão de Ripple* - O ripple é a diferença entre $V_"max"$ fornecido pela fonte + transformador + diodos e $V_"min"$ que o capacitor consegue fornecer antes de recuperar carga. (R = Resistência da carga)

$ V_"rpp" = V_"max" (1-e^(-1/(f R C))) $

2. *Lei de Ohm* - Clássico.

$ v = R i $

3. *LKC* - Lei de Kirschoff das Correntes.

$ sum i_"sai" = sum i_"entra" $

4. *LKT* - Lei de Kirschoff das tensões.

$ sum V = 0 $

5. *Relação entre $V_"max" "e" V_"rms"$* - Válido apenas para fontes senoidais puras (tomada, antes dos diodos).

$ V_"max" = sqrt(2) dot V_"rms" $

6. *Equação do transformador*

$ N_1/N_2 = V_"in-rms"/V_"out-rms" $


E o que queremos calcular?

#figure(
  image("./images/diagram.png", width: 100%),
  caption: [Diagrama do Circuito de Fonte.],
)

Bom, os componentes que precisam de atenção são:

- Capacitor: Precisa suportar a tensão da fonte e ter capacitância para um bom Ripple
- LED: Precisa operar abaixo da corrente máxima
- Zenner: Precisa receber uma tensão acima da tensão de ruptura e suportar a corrente

== Calculando corrente total

Na direita do circuito, temos componentes estáticos. 

#figure(
  image("./images/resistance-circuit.png", width: 80%),
  caption: [Circuito RC com fonte AC],
)

Para calcular a corrente total, vamos calcular por partes e fazer a somatória das correntes.

=== LED + $R_"led"$

Aqui é simples. Consideramos o LED como um curto-circuito (baixa resistência) e temos apenas o resistor.

$ I_1 = (V_0-V_"led")/R_"led" $

Conseguimos encontrar a primeira corrente que sai do nó.

Já podemos calcular, inclusive, a Resistência que precisamos colocar no LED. Vamos considerar um LED difuso comercial comum @led-shopping com $V_"led" = 1.6V$ (LED vermelho) e corrente máxima de 20mA.

Vamos tentar obter uma corrente ideal de 15mA.

$ 0.015 = (V_0-2)/R_"led" $
$ R_"led" = (V_0-2)/0.015 $

Para obter a resistência mais segura, precisamos considerar $V_"max" = 25V$ para maximizar o valor da nossa resistência.

$ R_"led"_"max" = (V_"max"-2)/0.015 = (25-2)/0.015 = 1533 k Omega$

Assim, a resistência mínima ideal é de $1550 k Omega$. Vamos utilizar $R_"led" = 1.5 k Omega$.

=== Resistor R1 + Zenner

O Zenner, após a tensão de ruptura, atua como uma fonte de tensão DC. Assim, a corrente $I 2$ que passa pelo R1 é:

$ I_2=(V_0-V_z)/R_1 $

Conseguimos encontrar a segunda corrente que sai do nó.

=== Potenciômetro + R2

Aqui, vamos calcular a tensão que vai para a base do transistor. Vamos chamar as resistências internas do potenciômetro de $R_"1p", R_"2p"$.

A construção do potenciômetro o torna um divisor de tensão nato. Segue a configuração de um divisor de tensão qualquer:

#figure(
  image("./images/tension-divider.png", width: 80%),
  caption: [Circuito RC com fonte AC],
)

Ali no circuito temos o mesmo, mas o resistor de baixo é a soma de $R_"2p" + R_2$. Assim, temos na base do transistor:

$ V_B = ((R_"2p" + R_2)/(R_"1p" + R_"2p" + R_2))V_z $

=== Transistor

Para o transistor, temos:

$ I_E = I_B + I_C $ e $ beta = I_C/I_B $

Unindo os dois, temos: 

$ I_E = I_C dot (1/beta + 1) $

A tensão da base, em um transistor, é replicada ao emissor, porém com uma pequena perda (como no diodo). Vamos chamar essa perda de $V_"BE"$.

$ V_E = V_B - V_"BE" $

Por lei de Ohm, temos na carga:

$ I_E = V_E/R_q = (V_B-V_"BE")/R_q $

Igualando ao $I_E$ encontrado anteriormente:

$ I_C dot (1/beta + 1) = (V_B-V_"BE")/R_q $
$ I_C = (V_B-V_"BE")/(R_q dot (1/beta + 1)) $

Conseguimos encontrar a última corrente que sai do nó.

=== Unindo tudo e calculando corrente total

Agora, basta somar as correntes que saem do nó para obter a corrente total que entra.

$ I_t = I_1 + I_2 + I_C $

$ I_t = (V_0-V_"led")/R_"led" + (V_0-V_z)/R_1 + (V_B-V_"BE")/(R_q dot (1/beta + 1)) $

E para fins práticos, é melhor substituir $R_q = V_E / I_E$, onde $ V_E = V_B - V_"BE" $ (é mais fácil dizer a corrente máxima/mínima do que a resistência máxima/mínima de uma bateria).

$ I_t = (V_0-V_"led")/R_"led" + (V_0-V_z)/R_1 + (V_B-V_"BE")/(R_q dot (1/beta + 1)) $

E para obter a resistência equivalente, basta usar $V_0 = R_"eq"I_t$

$ I_t = (V_0-V_"led")/R_"led" + (V_0-V_z)/R_1 + (V_B-V_"BE")/(((V_B-V_"BE") / I_E) dot (1/beta + 1)) $

$ I_t = (V_0-V_"led")/R_"led" + (V_0-V_z)/R_1 + I_E/(1/beta + 1)) $

== Achando tensão máxima

Resolver isso é simples. A tensão máxima, após passar pelo transformador e pelos diodos, é dada por:

$ V_"max" = V_"max-transformador" - 2 dot V_"d" $

Vamos considerar uma tensão de 127V RMS. A tensão de pico (máxima) é dada por $V_"max"=sqrt(2) dot V_"rms" = 180V$.

Para calc

Para os transformadores do laboratório, obtendo a saída experimentalmente, podemos calcular a razão $N 1/N 2$:

$ N_1/N_2 = 127/V_"out-rms" $

(Obs: $V_"in-rms"$)

#table(
  columns: (auto, 1fr, 1fr), // auto = largura do conteúdo, 1fr = fração do espaço restante
  fill: (x, y) => if y == 0 { gray.lighten(50%) }, // Colore a primeira linha
  [Transformador], [Saída RMS (V)], [N1/N2],
  [1,2,4,5], [18.1], [7],
  [3], [16.3], [11.5],
  [6], [11], [7.9]
)

Quanto menor a razão $N_1/N_2$, maior $V_"out"$. Por segurança, vamos utilizar o menor valor de modo a considerar o pior caso.

$ V_"out-rms" = N_2/N_1 dot 127 = 1/7 dot 127 = 18.14 V $

$ V_"max" = sqrt(2) dot V_"out-rms" - 2 dot V_"d" $

Vamos considerar o pior caso (diodos de Silício, que consomem entre 0.2V e 0.3V).

$ V_"max" = sqrt(2) dot 18.14 - 2 dot 0.2  = 25.25 V $

== Achando R2

Para o divisor de tensão com potenciômetro e R2, temos que: 

$ V_B = ((R_"2p" + R_2)/(R_"1p" + R_"2p" + R_2))V_z $

Isolando $V_B$:

$ R_2 = (V_("B")(R_"1p" + R_"2p") - V_z R_"2p")/(V_z - V_"B") $

Utilizaremos a tensão mínima, pois a tensão máxima é definida pelo Zenner (13 V), com algumas pequenas perdas. A tensão mínima é definida pelo valor de R2.

Temos:

- $R_"1p" + R_"2p" = 10 k Omega$
- $V_"B(min)" = 3.7V$ (3V + 0.7V dissipados)

Como queremos a resistência mínima, esta será o máximo valor da equação acima, que é dado quando $R_"rp" = 0$. Assim:

$ R_2 = (V_("B(min)")(R_"1p" + R_"2p"))/(V_z - V_"B(min)") $

$ R_2 = (3.7 dot 10 000)/(13 - 3.7) = 3978 approx 4 k Omega $

Vamos escolher $R 2  = 4.5 k Omega$.

== Achando R1 

A função do resistor R1 é garantir que a corrente que sobra para o Zener seja maior que a corrente mínima de ruptura. A boa notícia é que, com o transistor, a alimentação da carga não puxa muita corrente a ponto de desligar o Zenner.

Para um Zenner In4743 de 13V, temos:

- $I_"min" = 19 m A$ - Corrente ideal. Abaixo disso, a resistência do Zenner começa a aumentar, e não garante os 13V.
- $I_"max" = 69 m A$ - Acima disso, queima.

Vamos tentar obter essa corrente ideal no diodo zenner. Pra isso, primeiro vamos calcular a corrente que vai pra base do transistor. Temos:

$ beta = I_C/I_B , I_C = (V_B - V_"BE")/(R_q dot (1/beta + 1)), V_B = ((R_"2p" + R_2)/(R_"1p" + R_"2p" + R_2))V_z $

Unindo tudo, temos:

$ I_B beta = (V_B - V_"BE")/(R_q(1/beta + 1)) $
$ I_B = (((R_"2p" + R_2)/(R_"1p" + R_"2p" + R_2))V_z - V_"BE")/(R_q dot (1 + beta)) $

De outra forma, também temos: 

$ I_B = I_E/(1 + beta) $

Faz mais sentido pensar em $I_B$ usando a corrente máxima de saída que esperamos para a carga.

E para a corrente que desce pra baixo do potenciômetro:

$ I_"pot" = V_z/(R_"1p" + R_"2p" + R_2) $

Ok. Agora, para R1, temos:

$ I_r = (V_0 - V_z)/R_1, I_r = I_z + I_B + I_"pot" $

Substituindo para deixar tudo em função de R1:

$ (V_0 - V_z)/R_1 = I_z + I_B +I_"pot"$
$ R_1 = (V_0 - V_z)/(I_z + I_B +I_"pot") $
$ R_1 = (V_0 - V_z)/(I_z + I_E/(1 + beta) + V_z/(R_"1p" + R_"2p" + R_2)) $

=== Cenário 1: Garantindo que o Zener não desligue

Para que o Zener não desligue:

$ R_1_"max" = (V_"0(min)"-V_z)/(I_"z(min)"+I_"B(max)"+I_"pot") $

Vamos usar:

- $V_0 = V_"min" = 23V$
- $V_z = 13V$
- $R_2 = 4.5K Omega$
- $V_"BE" = 0.7V$
- $R_"1p" + R_"2p" = 10 k Omega$
- $beta = 100$
- $I_z = I_"min" = 19 m A$
- $I_"max" = 2A$ - Valor estipulado com base na bateria real @ion-battery (Corrente de carga rápida = 1.3A)

$ R_1_"max" = (23 - 13)/(0.019 + 2/(1+100) + 13/(10000 + 4500)) = 252 Omega $

Qualquer resistor maior que este valor fará o Zener regular menos de 13 V no vale do ripple quando a carga puxar 2A.

=== Cenário 2: Garantindo que o Zener não queime

Para que o Zener não queime:

$ R_1_"min" = (V_"0(max)"-V_z)/(I_"z(max)"+0+I_"pot") $

Vamos usar:

- $V_0 = V_"max" = 25V$
- $V_z = 13V$
- $R_2 = 4.5K Omega$
- $V_"BE" = 0.7V$
- $R_"1p" + R_"2p" = 10 k Omega$
- $beta = 100$
- $I_z = I_"max" = 69 m A$
- $I_"min" = 0A$

$ R_1_"min" = (25 - 13)/(0.069 + 0 + 13/(10000 + 4000)) = 171 Omega $

Qualquer resistor menor que este valor fará o Zener queimar quando a carga for removida.

=== Conclusão de R1

R1 deve ser um valor entre:

$ 171 < R 1 < 252 $

Vamos escolher $R 1  = 200 Omega$.

== Capacitor

O capacitor precisa:

- Suportar a tensão da fonte
- Ter capacitância relevante para um Ripple baixo

=== Achando tensão ideal de capacitor

A tensão máxima no pior caso já foi dada anteriormente: 25.25V. Como a tensão máxima é de 25.25 V no pior caso, por segurança iremos utilizar um capacitor de 30V.

=== Achando capacitância ideal para o capacitor (refazendo)

Para um capacitor, temos:

$ C = Q/V = (triangle Q)/(triangle V) $

Como $ triangle Q = I triangle t$, por definição:

$ C = (I triangle t)/(V_"max" - V_"min") $

Aqui, estamos considerando uma corrente constante, uma variação de tensão (nosso $V_"max" - V_"rpp"$) e um tempo de descarga $triangle t$.

Vamos calcular esse tempo de descarga. Bom, vamos considerar que, para uma onda cossenoide, o ângulo onde $V_"max"$ é atingido é em 0°.

$ V_"fonte-ret" = 25|cos(2pi f t)| = 25|cos(120 pi t)|$

Precisamos descobrir em qual ângulo a próxima onda atinge os 16.7V para iniciar a recarga.

1. A onda tem seu pico em t = 0 e começa a cair. Aqui, o capacitor começa a descarregar.
2. A onda atinge 0V em $pi/2$
3. Entre $pi/2$ e $pi$ a onda atinge o valor mínimo para o capacitor parar de descarregar, que é o $ V_"min" = 15V$ que queremos.

$ 25cos(theta) = 15 arrow.r.double theta = arccos(15/25) = 0.927 "rad" $

Assim, a onda tem que percorrer $pi - 0.927$ rad desde o pico até encontrar o capacitor novamente.

$ w = 2 pi f = 120 pi , w = (triangle theta) / (triangle t) $
$ t = (triangle theta) / (120 pi) arrow.r.double t = (pi - 0.927) / (120 pi) = 0.00587 s $

Para calcular a capacitância mínima, vamos encontrar a corrente máxima para nosso cenário, utilizando a fórmula de corrente total que calculamos anteriormente.

Vamos utilizar:

- $V_0 = V_"max" = 25$V
- $R_"led" = 1.5 k Omega$
- $V_z = 13V$
- $V_"BE" = 0.7V$
- $I_E = 2A$ - Corrente máxima do celular (caso onde a Req é mínima)
- $beta = 100$ (mínimo)
- $R_1 = 200 Omega, R_2 4 k Omega$

$ I_t = (V_0-V_"led")/R_"led" + (V_0-V_z)/R_1 + I_E/(1/beta + 1) $
$ I_t = (25-2)/1500 + (25-13)/200 + 2/(1/100 + 1) = 2,06 A $

Agora, apenas substituímos tudo na equação da capacitância:

$ C = (I triangle t)/(V_"max" - V_"min") = (2.06 dot 0.00587)/(25 - 15) = 1209 mu F $

Portanto, nosso capacitor deve ter no mínimo $ 1200 m F$ para a fonte conseguir entregar uma corrente DC estável no pior cenário possível (carga consumindo 2A).

Ao testar no Falstad com as mesmas condições iniciais dadas, verificamos que realmente, nesse valor de capacitância a tensão permanece minimamente estável, e abaixo dele ela começa a flutuar muito.

Vamos escolher um capacitor de 1500 $mu$F, para ter uma folga.

= Lista de componentes

Dados os cálculos, podemos fazer a lista de componentes. Vamos retomar o que calculamos.

- $R_"led"_"min" = 1.5 k Omega$ - Escolheremos $R_"led" = 1200 Omega$
- $171 Omega< R_1 < 252 Omega$ - Escolheremos $R_1 = 200 Omega$
- $R_2_"min" = 3978 Omega$ - Escolheremos $R_2 = 4.5 k Omega$
- $V_"max" = 25,25 V$ - Escolheremos uma tensão máxima para o capacitor de 30V
- $C_"min" = 1209 mu F$ - Escolheremos $C = 1500 mu F$
- $I_"max" = 2 A$ (transistor) - Escolheremos $I_"max" = 3A$ para o transistor
- $I_t_"max" = 2.06 A$ (diodos) - Escolheremos $I_"max" = 3A$ para os diodos

Agora podemos fazer a lista de componentes.

- 1 placa ilhada de cobre
- Jumpers
- 4 diodos $I_"max" = 3A$
- 1 capacitor $C = 1500 mu F$, $V_"max" = 30V$
- Resistores de $100 Omega$, $1k Omega$
- 1 potenciômetro $10 k Omega$
- 1 transistor $I_"max" = 3A$, $V_"max" = 30V$ 

= Valor das peças

O valor total das peças gastas no conjunto foi de R\$ 78,40, incluindo:

- 2 Capacitores 1500uF 63V - R\$ 15,00
- Resistores 3 Ohms (foi comprado errado) - R\$ 5,00
- Resistores 1k - R\$ 8,00
- LED verde - R\$ 2,90
- 5 Diodos Zenner - R\$ 7,50
- Placa ilhada de cobre - R\$ 14,00
- 4 diodos 3A (não foram utilizados, pernas muito grossas) - R\$ 10,00
- 1 Ponte Retificadora 2A - R\$ 4,00
- 1 Potenciômetro B10K - R\$ 7,00
- Conector USB Fêmea - R\$ 5,00

= Projeto na prática: Ajustes

Na prática, utilizamos uma fonte cuja medida de corrente alternada resultou em 16 V. Ao colocá-la no circuito, a medida de corrente contínua resultou em 22V.

O projeto funcionou perfeitamente, e todos os valores de componentes atenderam perfeitamente o circuito nessa configuração, exceto por dois:

- Ajustamos $R_1$ para $1.2 k Omega$, pois o diodo Zenner estava superaquecendo (muita corrente passando), a ponto de quase queimar. A resistência anterior era pequena demais.

- Ajustamos $R_2$ para $3.5 k Omega$, pois a d.d.p. mínima na carga estava atingindo $3.5 V$. Com esse ajuste, a d.d.p. mínima atingiu $3 V$, e a máxima, $12.67 V$.

Desse modo, conseguimos uma tensão de corrente contínua estável ajustável entre 3V e 12.67V.

O projeto da fonte foi concluido com sucesso.

= Apêndice: Achando tensão de Ripple analiticamente

Vamos considerar um circuito RC com uma fonte cujo sinal seja $V_"fonte"(t)=V_"max"cos(w t)$, de modo que $w = 2pi f$. A malha da direita representa o restante do nosso circuito, que não contém componentes dinâmicos.

#figure(
  image("./images/font-filter-circuit.png", width: 60%),
  caption: [Circuito RC com fonte AC],
)

Vamos considerar que no instante inicial t = 0 o capacitor está carregado, e a onda da fonte está no seu pico $V_"max"$.

== Analisando malhas

Se analisarmos a primeira malha (fonte + capacitor):

$ V_"fonte"(t) = V_"d1" + V_"d2" + V_c(t) $
$ (V_"fonte"(t) - V_"d1" + V_"d2") = V_c(t) $

Se analisarmos a malha externa (fonte + resistor):

$ (V_"fonte"(t) - V_"d1" + V_"d2") = V_r(t) $

Assim, a tensão gerada pelo capacitor é igual à tensão da fonte menos 2x a queda de tensão dos diodos. Se o capacitor não estivesse ali, não faria diferença. Ele simplesmente acompanha a fonte. Com os diodos, a "fonte" enxergada pelo capacitor e pela carga é: 

$ V(t) = V_"fonte"(t) - V_"d1" - V_"d2" $

Vamos utilizar apenas $V(t)$ nas equações para simplificar, mas é importante considerar essas perdas dos diodos, de modo que:

$ V_"max" = V_"max-fonte" - V_"d1" - V_"d2" $

"Mas o capacitor não integra/deriva?" Sim, quando está em série com um resistor. Sem o resistor, ele apenas acompanha a fonte, pois é carregado/descarregado instantaneamente de acordo com a d.d.p. diretamente com a fonte.

Mas o capacitor não deveria integrar/derivar o sinal da fonte, de modo que ele apenas seguiria o sinal da fonte com um atraso? Bom, sim, se não fosse pelos diodos. Estamos esquecendo deles.
 
Vamos imaginar $t = 0$, tudo descarregado. Os diodos permitem que a corrente flua da fonte para o circuito, até a tensão chegar no pico. Quando a tensão começa a cair, o capacitor começa a descarregar, de modo que ele vira uma espécie de "fonte". Os diodos não deixam a corrente fluir do capacitor para a fonte, de modo que o capacitor sozinho começa a alimentar o circuito e a fonte "some".

Então podemos considerar, aqui, um estado onde a fonte está removida do circuito, e temos apenas uma malha com capacitor (carregado) + resistor (carga).

Aplicando LKT:

$ V_c(t) + R C V'_c(t) = 0 $
$ V_c(t)/(R C) + V'_c(t) = 0 $

Isso é uma EDO linear de 1° ordem.

== Resolvendo EDO Linear de 1° ordem

Vamos resolver utilizando a função auxiliar.

$ mu = e^(integral 1/(R C) d t) = e^(t/(R C)) $

$ e^(t/(R C))V_c(t)/(R C) + e^(t/(R C))V'_c(t) = 0 $

Integrando dos dois lados:

$ e^(t/(R C))V_c(t) = integral 0 d t $
$ e^(t/(R C))V_c(t) = k $
$ V_c(t) = k e^(-t/(R C)) $

O início da descarga (t = 0) é justamente quando o capacitor está em $V_"max"$.

$ V_c(0) = V_"max" = k e^(-0/(R C)) $
$ V_"max" = k $

Assim, temos a equação de descarga exponencial do capacitor:

$ V_c(t) = V_"max" dot e^(-t/(R C)) $

== Achando t tal que $V_c(t) = V_"fonte"(t)$

Com isso, precisamos achar agora a tensão mínima que o capacitor fornece até parar de descarregar. A tensão de ripple será dada por:

$ V_"rpp" = V_"max" - V_"min" $

Pois a tensão fornecida ao resto do circuito ficará entre $V_"max"$ e $V_"min"$.

E quando o capacitor para de descarregar? Quando a tensão dele, que está caindo, se iguala à da fonte, que está subindo, e os diodos (nossos portões) se abrem novamente, de modo que $V_c(t)$ começa a acompanhar $V(t)$ tal que $V_c(t) = V_(t)$.

O problema é que ao igualar $V_c(t) = V(t)$ para tentar achar t onde as tensões se igualam, chegamos numa equação sem resultado analítico para $t != 0$.

$ V_c(t) = V(t) $
$ V_"max" dot e^(-t/(R C)) = V_"max"cos(w t) $
$ -t/(R C) = ln(cos(w t)) $

Portanto, usamos uma aproximação. Considerando que queremos projetar a fonte com o Ripple o mais pequeno possível, podemos aproximar que $V_c(t)$ só irá encontrar $V_"fonte"$ novamente no próximo pico de tensão da fonte. Isso dá um período completo:

$ t = T = 1/f $

E utilizamos $V_c(T) = V_"min"$.

== Encontrando tensão de Ripple

A tensão de ripple é dada por:

$ V_"rpp" = V_"max" - V_"min" $

Utilizando as equações encontradas anteriormente, chegamos no valor final para Ripple.

$ V_"rpp" = V_"max" - V_"max" dot e^(-1/(f R C)) $
$ V_"rpp" = V_"max" dot (1 - e^(-1/(f R C))) $

== Aproximação por Taylor

Podemos simplificar essa equação. Como o tempo de descarga em 60 Hz retificado em onda completa é muito curto ($triangle t = 1/(2f)$​), aproximamos a exponencial por uma reta via Expansão de Taylor.

Por Expansão de Taylor de 1° Ordem:

$ f(t - t_0) approx f(t_0) + 1/1! f'(t - t_0)(t-t_0) $

Considerando $t_0 = 0$:

$ V_c(t) approx V_"max" + (-V_"max"/(R C)e^(-0/(R C)))t $
$ V_c(t) approx V_"max" dot (1 - t/(R C)) $

Novamente, consideramos $V_c(T) = V_"min"$.

$ V_"rpp" = V_"max" - V_"min" $
$ V_"rpp" = V_"max" - V_"max" dot (1 - 1/(f R C)) $
$ V_"rpp" = V_"max" dot (1 - t/(R C)) $


// Bibliografias
#bibliography("refs.bib")