#let i18n-strings = (
  en: (
    abstract: "Abstract",
    toc: "Table of Contents",
    chapter: "Chapter",
    part: "Part",
    appendix: "Appendix",
    figure: "Figure",
    table: "Table",
    proof: "Proof",
    theorem: "Theorem",
    lemma: "Lemma",
    definition: "Definition",
    example: "Example",
    algorithm: "Algorithm",
    page: "Page",
  ),
  fr: (
    abstract: "Résumé",
    toc: "Table des matières",
    chapter: "Chapitre",
    part: "Partie",
    appendix: "Annexe",
    figure: "Figure",
    table: "Tableau",
    proof: "Preuve",
    theorem: "Théorème",
    lemma: "Lemme",
    definition: "Définition",
    example: "Exemple",
    algorithm: "Algorithme",
    page: "Page",
  ),
)

#let get-strings(lang) = {
  if lang in i18n-strings {
    i18n-strings.at(lang)
  } else {
    i18n-strings.en
  }
}
