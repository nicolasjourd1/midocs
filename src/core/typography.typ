#let typography-presets = (
  default: (
    body-font: "Linux Libertine",
    heading-font: "Linux Libertine",
    code-font: "FiraCode Nerd Font Mono",
    heading-weight: "bold",
  ),

  modern: (
    body-font: "Inter",
    heading-font: "Inter",
    code-font: "JetBrains Mono",
    heading-weight: "semibold",
  ),

  classic: (
    body-font: "TeX Gyre Termes",
    heading-font: "TeX Gyre Termes",
    code-font: "Courier New",
    heading-weight: "bold",
  ),
)

#let get-typography(name) = {
  if name in typography-presets {
    typography-presets.at(name)
  } else {
    typography-presets.default
  }
}
