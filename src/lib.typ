#import "core/config.typ": get-default-config, merge-config
#import "core/themes.typ": get-theme
#import "core/typography.typ": get-typography
#import "core/i18n.typ": get-strings

#import "templates/article.typ": article-template
#import "templates/report.typ": report-template
#import "templates/book.typ": book-template

#import "utils/math.typ": *
#import "utils/cs.typ": *

#import "utils/math.typ": config-state

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
