#let RR = $bb(R)$
#let NN = $bb(N)$
#let ZZ = $bb(Z)$
#let QQ = $bb(Q)$
#let CC = $bb(C)$

#let config-state = state("midocs-config", none)

#let env-counter = counter("example")


#let env(kind, title: none) = body => context {
  let config = config-state.get()
  let accent = config.theme.secondary
  let primary = config.theme.primary
  let kind-label = config.strings.at(kind, default: "Unknown kind")

  env-counter.step()

  block(
    width: 100%,
    inset: 10pt,
    stroke: (left: 3pt + accent),
    fill: accent.lighten(80%),
  )[
    #text(weight: "bold", fill: primary)[
      #kind-label
      #context env-counter.display("1")
      #if title != none [ (#title)]
      #if title == none [.]
      #h(0.25em)
    ]
    #body
  ]
}

#let theorem(title: none, body) = env("theorem", title: title)(body)
#let lemma(title: none, body) = env("lemma", title: title)(body)
#let definition(title: none, body) = env("definition", title: title)(body)
#let example(title: none, body) = env("example", title: title)(body)

#let proof(body) = context {
  let config = config-state.get()
  let proof-label = config.strings.proof
  block(
    width: 100%,
    inset: 10pt,
  )[
    #text(style: "italic")[#proof-label.#h(0.25em)]
    #body
    #h(1fr) $qed$
  ]
}
