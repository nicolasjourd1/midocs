#import "src/core/config.typ": get-default-config, merge-config
#import "src/core/themes.typ": get-theme
#import "src/core/typography.typ": get-typography
#import "src/core/i18n.typ": get-strings

#import "src/templates/article.typ": article-template
#import "src/templates/report.typ": report-template
#import "src/templates/book.typ": book-template

#import "src/utils/math.typ": *
#import "src/utils/cs.typ": *

#import "src/utils/math.typ": config-state

#let build-config(
  type: "article",
  theme: "default",
  typography: "default",
  lang: "fr",
  config: (:),
) = {
  let base-config = get-default-config(type)
  let final-config = merge-config(base-config, config)

  let theme-colors = get-theme(theme)
  let typo = get-typography(typography)
  let strings = get-strings(lang)

  (
    ..final-config,
    theme: theme-colors,
    typography: typo,
    strings: strings,
    lang: lang,
  )
}

#let make-document(
  type: "article", // article, report, book
  theme: "default", // default, dark, modern
  typography: "default", // default, modern, classic
  lang: "fr", // en, fr
  config: (:), // custom config overrides
  body,
) = {
  let full-config = build-config(
    type: type,
    theme: theme,
    typography: typography,
    lang: lang,
    config: config,
  )

  config-state.update(full-config)

  if type == "article" {
    article-template(full-config, body)
  } else if type == "report" {
    report-template(full-config, body)
  } else if type == "book" {
    book-template(full-config, body)
  }
}

// Re-export
#let theorem = theorem
#let lemma = lemma
#let definition = definition
#let example = example
#let proof = proof
#let RR = RR
#let NN = NN
#let ZZ = ZZ
#let QQ = QQ
#let CC = CC
#let bigO = bigO
#let bigTheta = bigTheta
#let bigOmega = bigOmega
#let algorithm = algorithm
// Export config builder as 'c'
#let c = build-config
