#let themes = (
  default: (
    primary: rgb("#1e40af"),
    secondary: rgb("#6366f1"),
    accent: rgb("#f59e0b"),
    text: rgb("#1f2937"),
    background: rgb("#ffffff"),
    code-bg: rgb("#f3f4f6"),
    heading: rgb("#111827"),
  ),

  academic: (
    primary: rgb("#991b1b"),
    secondary: rgb("#7c2d12"),
    accent: rgb("#92400e"),
    text: rgb("#000000"),
    background: rgb("#ffffff"),
    code-bg: rgb("#fef3c7"),
    heading: rgb("#450a0a"),
  ),
)

#let get-theme(name) = {
  if name in themes {
    themes.at(name)
  } else {
    themes.default
  }
}
