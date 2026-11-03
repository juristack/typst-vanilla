#import "../src/lib.typ": vanilla

#set page(paper: "us-letter", margin: 1in)

#show: vanilla.with(
  styles: (
    body: (
      font: "Times New Roman",
      size: 11pt,
      spacing: "double",
    ),
  ),
)

= Double spacing

This paragraph tests that double spacing remains unchanged.

This second paragraph tests paragraph separation.

This third paragraph provides additional lines for visual inspection.
