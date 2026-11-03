#!/usr/bin/env python3
import math
import sys
import pymupdf

WORD = {
    "single": {
        "line_pitch": 12.78,
        "paragraph_pitch": 20.52,
        "line_tolerance": 0.15,
        "paragraph_tolerance": 0.15,
    },
    "double": {
        "line_pitch": 25.32,
        "paragraph_pitch": 33.30,
        "line_tolerance": 0.15,
        "paragraph_tolerance": 0.35,
    },
}


def fail(message):
    print(f"FAIL: {message}")
    sys.exit(1)


def check(condition, message):
    if not condition:
        fail(message)
    print(f"PASS: {message}")


def close(actual, expected, tolerance):
    return math.isclose(actual, expected, abs_tol=tolerance)


def inspect(path, spacing):
    expected = WORD[spacing]
    doc = pymupdf.open(path)

    try:
        check(len(doc) == 1, f"{spacing}: one-page document")
        page = doc[0]

        check(
            close(page.rect.width, 612, 0.01)
            and close(page.rect.height, 792, 0.01),
            f"{spacing}: US Letter page (612 x 792 pt)",
        )

        lines = []
        for block in page.get_text("dict")["blocks"]:
            for line in block.get("lines", []):
                spans = line.get("spans", [])
                if not spans:
                    continue

                text = "".join(span["text"] for span in spans)
                if text.strip():
                    lines.append({
                        "x": spans[0]["origin"][0],
                        "y": spans[0]["origin"][1],
                        "text": text,
                        "spans": spans,
                    })

        check(len(lines) == 14, f"{spacing}: 14 nonempty text lines")

        all_spans = [span for line in lines for span in line["spans"]]

        check(
            all(span["font"] == "TimesNewRomanPSMT" for span in all_spans),
            f"{spacing}: all text uses Times New Roman",
        )
        check(
            all(close(span["size"], 11.04, 0.02) for span in all_spans),
            f"{spacing}: all text is 11.04 pt",
        )

        for index, line in enumerate(lines):
            expected_x = 108 if index % 2 == 0 else 72
            check(
                close(line["x"], expected_x, 0.1),
                f"{spacing}: line {index + 1} indentation",
            )

        intervals = [
            lines[i + 1]["y"] - lines[i]["y"]
            for i in range(len(lines) - 1)
        ]

        for paragraph in range(7):
            pitch = intervals[paragraph * 2]
            check(
                close(pitch, expected["line_pitch"], expected["line_tolerance"]),
                f"{spacing}: paragraph {paragraph + 1} line pitch "
                f"({pitch:.3f} pt; Word {expected['line_pitch']:.2f} pt)",
            )

            if paragraph < 6:
                transition = intervals[paragraph * 2 + 1]
                check(
                    close(
                        transition,
                        expected["paragraph_pitch"],
                        expected["paragraph_tolerance"],
                    ),
                    f"{spacing}: paragraph {paragraph + 1} transition "
                    f"({transition:.3f} pt; Word ~{expected['paragraph_pitch']:.2f} pt)",
                )

        print(f"PASS: {spacing} spacing matches Word reference tolerances")
    finally:
        doc.close()


if __name__ == "__main__":
    if len(sys.argv) != 3 or sys.argv[2] not in WORD:
        fail("usage: check-word-spacing.py PDF single|double")
    inspect(sys.argv[1], sys.argv[2])
