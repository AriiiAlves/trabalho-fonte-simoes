// Isso é um comentário
#set page(paper: "a4") // Configurações globais
#set text(font: "Arial", size: 12pt) 
#set heading(numbering: "1.1") // Isso numera as seções (1, 1.1, etc.)
#set bibliography(title: "Referências", style: "ieee") // Define bibliografia

= Título do Artigo

#outline(title: "Sumário")

== Compilando

- Para compilar em typst: `typst compile arquivo.typ`
- Modo observação (monitora alterações e recompila automaticamente): `typst watch arquivo.typ`
== Estilos

*Negrito*, _Itálico_, #underline[Sublinhado], #strike[Tachado]. `Código em linha`, #link("https://typst.app/home")[Link (typst.app)]

```python
def hello():
  print("Código em bloco")
```

Lista:
- Item 1
- Item 2
  - Sub-item

Tabela:

#table(
  columns: (auto, 1fr, 1fr), // auto = largura do conteúdo, 1fr = fração do espaço restante
  fill: (x, y) => if y == 0 { gray.lighten(50%) }, // Colore a primeira linha
  [ID], [Produto], [Preço],
  [1], [Teclado], [R\$ 150],
  [2], [Mouse], [R\$ 80]
)

Figura:

#figure(
  image("./image.jpg", width: 50%),
  caption: [Legenda da minha figura.],
)

#quote(attribution:"Autor", block: true)[
  *Citação*
]

#block(inset: 1cm, fill: luma(240))[
  *Bloco:* Personalizável
]

#grid(
  columns: (1fr, 0.5pt, 1fr), // Divide o espaço em duas colunas de tamanhos iguais
  column-gutter: 20pt, // Espaço entre as colunas
  stroke: (x, y) => if x == 1 { (right: 0.5pt + black) }, // Define que a coluna do meio (index 1) terá traço preto
  [
    // Conteúdo da esquerda
    #rect(width: 100%, height: 100pt, fill: blue.lighten(80%))[Coluna Esquerda]
  ],
  [],
  [
    // Conteúdo da direita
    #rect(width: 100%, height: 100pt, fill: red.lighten(80%))[Coluna Direita]
  ]
)

== Matemática

// LaTeX: \sum_{i=0}^{n} i^2
// Typst:
$ sum_(i=0)^n i^2 = (n(n+1)(2n+1)) / 6 + sqrt(c) $

matrizes e sistema:
$ mat(1, 0; 0, 1) $  // Matriz identidade 2x2
$ cases(
  2x + y = 5,
  x - y = 1
) $

== Variáveis e modo código

// Usando variáveis
#let autor = "Ariel"

O autor deste artigo é #autor.

// Definindo uma função personalizada
#let alerta(cor, corpo) = {
  rect(fill: cor, radius: 5pt, inset: 10pt, corpo)
}

// Chamando a função
#alerta(red.lighten(80%), [Este é um aviso importante!])

// Modo código
#let contador = 0
#while contador < 3 {
  [O número é #contador \ ]
  contador += 1
}

== Bibliografia

Eu estou usando esse repositório@alves2026.

#bibliography("refs.bib")