= Tentando achar ripple em circuito RC (deixei de lado, esqueci que não tem R)

Vamos considerar um circuito RC com uma fonte cujo sinal seja $V(t)=V_"max"cos(w t)$, de modo que $w = 2pi f$. A malha da direita representa o restante do nosso circuito, que não contém componentes dinâmicos.

#figure(
  image("./images/font-rc-circuit.png", width: 80%),
  caption: [Circuito RC com fonte AC],
)

Vamos considerar que o sinal vem de um retificador de onda completa. Também vamos enumerar a malha da esquerda = 1 e malha da direita = 2.

Também vamos considerar que no instante inicial t = 0 o capacitor está carregado, e a onda da fonte está no seu pico $V_"max"$. Assim, vamos analisar a tensão fornecida ao circuito conforme o capacitor descarrega, até começar a carregar novamente. Em todo o período analisado, $V_c > V(t)$.

Aplicando Lei de Kirschoff das Tensões na malha 1 e considerando para um capacitor a relação fundamental $Q(t) = C V_c (t)$, temos:

$ sum V = 0 arrow.r.double Q(t)/C +R i_1 = V(t) $

Intuitivamente, a corrente que passa pelo resistor é a que está indo alimentar a carga do capacitor. Por definição, a corrente no capacitor é dada por:

$ i = Q'(t) $

Como o resistor está em série com o capacitor, a corrente que passa por ele é a mesma.

$ Q(t)/C +R Q'(t) = V(t) $

Como queremos a tensão $V_c(t)$, podemos usar a relação fundamental do capacitor, com $ Q'(t) = C V'(t)$.

Temos uma EDO linear de 1° ordem. Vamos considerar $V(t)=V_"max"cos(w t)$.

$ V_c(t) + R C V'_c(t) = V_"max"cos(w t)$
$ V_c(t)/(R C) + V'_c(t) = V_"max"cos(w t)/(R C) $

Vamos resolver por função auxiliar, multiplicando os dois lados da equação por $mu$.

$ mu = e^(integral 1/(R C) d t) = e^(t/(R C)) $

$ e^(t/(R C)) dot  V_c(t)/(R C) + e^(t/(R C)) dot V'_c(t) = e^(t/(R C)) dot V_"max"cos(w t)/(R C) $

Agora integramos.

$ V_c(t) dot e^(t/(R C)) = integral e^(t/(R C)) dot V_"max"cos(w t)/(R C) d t $
$ V_c(t) dot e^(t/(R C)) = V_"max"/(R C) integral e^(t/(R C)) dot cos(w t) d t $
$ V_c(t) dot e^(t/(R C)) = V_"max"/(R C) dot [((R C)^2 dot e^(t/(R C)))/(1 + (w R C)^2) (cos(w t)/(R C) + w sin(w t)) + k] $
$ V_c(t) = V_"max" dot ((cos(w t) + w R C sin(w t))/(1 + (w R C)^2)) + k e^(-t/(R C)) $

Temos a condição de que em t = 0, a tensão no capacitor é igual à tensão da fonte (tensão máxima) $V_c(0) = V_"max"$.

$ V_"max" = V_"max" dot ((1)/(1 + (w R C)^2)) + k $
$ k = V_"max" dot (1 - (1)/(1 + (w R C)^2)) $

Portanto, temos nossa equação final.

$ V_c(t) = V_"max" dot ((cos(w t) + w R C sin(w t))/(1 + (w R C)^2)) + V_"max" dot (1 - (1)/(1 + (w R C)^2)) dot e^(-t/(R C)) $

$ V_c(t) = V_"max" dot [(cos(w t) + w R C sin(w t))/(1 + (w R C)^2) + (1 - (1)/(1 + (w R C)^2)) dot e^(-t/(R C))] $

E a tensão de ripple vai ser:

$ V_"rpp" = V_"max" - V_"min" $

A tensão mínima será, considerando o decaimento de $V_c(t)$, quando $ V_c(t) = V_"fonte"(t)$ na subida da fonte (módulo).

$ V_c(t) = - V(t) $

$ V_"max" dot [(cos(w t) + w R C sin(w t))/(1 + (w R C)^2) + (1 - (1)/(1 + (w R C)^2)) dot e^(-t/(R C))] = - V_"max"cos(w t)/(R C) $