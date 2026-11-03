#import "../src/lib.typ": body

#set page(paper: "us-letter", margin: 1in)
#set text(font: "Times New Roman", size: 11pt)

= Direct body spacing

#body(spacing: "single")[
  This tests the direct body single-spacing resolver.

  This tests paragraph separation.
]

#body(spacing: "double")[
  This tests the direct body double-spacing resolver.

  This tests paragraph separation.
]
