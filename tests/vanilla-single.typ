#import "../src/lib.typ": vanilla

#set page(paper: "us-letter", margin: 1in)

#show: vanilla.with(
  styles: (
    body: (
      font: "Times New Roman",
      size: 11pt,
      spacing: "single",
    ),
  ),
)

= Single spacing

This paragraph tests the single-spacing resolver in vanilla.

This second paragraph tests paragraph separation.

This third paragraph provides additional lines for visual inspection.
