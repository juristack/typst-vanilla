#import "@local/vanilla:0.1.0": vanilla

#show: vanilla.with(
  body-line-spacing: "double",
  body-font-family: "Times New Roman",
)

#set par.line(numbering: "1:")
#for i in range(1, 25) {
  lorem(10)
  linebreak()
}

