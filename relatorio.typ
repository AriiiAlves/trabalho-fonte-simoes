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

O transformador é responsável por converter uma tensão de entrada $V_1$ em outra tensão de entrada $V_2$, que pode ser maior ou maior, dependendo na relação do número de espiras na entrada e na saída.

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

// Bibliografias
#bibliography("refs.bib")