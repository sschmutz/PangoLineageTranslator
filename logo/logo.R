library(hexSticker)
library(showtext)

## Loading Google fonts (http://www.google.com/fonts)
font_add_google("Roboto")
## Automatically use showtext to render text for future devices
showtext_auto()

sticker(here::here("logo", "README-table-example-1.pdf"),
        package = expression(~bolditalic(Pango)~bold(LineageTranslator)),
        p_y = 1.4, p_size = 30, p_color = "#3A0301", p_family = "Roboto",
        s_x = 1.05, s_y = 0.8, s_width = 0.65,
        h_fill = "#FFF0CA", h_color = "#E69000", h_size = 1.4,
        filename = here::here("man", "figures", "logo.png"),
        dpi = 900)
