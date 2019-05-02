/*
 * Filename: pa2Strings.h
 * Author: Matt Roth
 * UserId: cs30xgs
 * Date: May 1st, 2019
 * Sources of help: Given.
 */
#ifndef PA2_STRINGS_H
#define PA2_STRINGS_H

// Usage and argument parsing strings
#define STR_USAGE \
  "\nUsage: %s [on [off]]\n" \
  "\ton  -- The character printed for pixels that are on. Defaults to %c.\n" \
  "\toff -- The character printed for pixels that are off. Defaults to %c.\n" \
  "\n" \
  "Both on and off must be single characters in the ASCII range [%u, %u].\n\n"

#define STR_ERR_SINGLE_CHAR \
  "\n\tArgument '%s' (%s) is not a single char\n\n"
#define STR_ERR_CHAR_RANGE \
  "\n\tArgument '%s' (ascii %u) is not in range [%u, %u]\n\n"

// Command loop strings
#define STR_COMMAND_PROMPT ">>> "
#define STR_COMMAND_USAGE \
  "\nBit ops:\n" \
  "\tset    part0 part1 -- Turns pixels on where part0/part1 bits are 1.\n" \
  "\tclear  part0 part1 -- Turns pixels off where part0/part1 bits are 1.\n" \
  "\ttoggle part0 part1 -- Flips pixels where part0/part1 bits are 1.\n" \
  "\tinvert             -- Flips all pixels in the image.\n" \
  "Strings:\n" \
  "\tcharacter c -- Sets the character c into the image.\n" \
  "\t               Allowed characters: A-Z, a-z, 0-9.\n" \
  "\tsay str     -- Displays characters from str as a sequence of images.\n" \
  "Movement:\n" \
  "\tscrollHorizontal offset   -- Scrolls image horizontally.\n" \
  "\t                               positive offset scrolls right\n" \
  "\t                               negative offset scrolls left\n" \
  "\tscrollVertical offset     -- Scrolls image vertically.\n" \
  "\t                               positive offset scrolls down\n" \
  "\t                               negative offset scrolls up\n" \
  "\ttranslate offsetH offsetV -- Scrolls image offsetH horizontally and\n" \
  "\t                             offsetV vertically.\n" \
  "Misc:\n" \
  "\thelp -- Shows this help message.\n" \
  "\n" \
  "Press Ctrl + D to exit.\n\n"
#define STR_END_PROMPT "\n"

#define STR_ERR_BAD_COMMAND "\n\tBad command.\n\n"
#define STR_ERR_COMMAND_MISSING_ARG "\n\tMissing argument(s) for command.\n\n"
#define STR_ERR_EXTRA_ARG \
  "\n\tUnexpected extra argument(s) encountered in command.\n\n"
#define STR_ERR_CHAR_COMMAND_SINGLE \
  "\n\tcharacter argument must be a single char.\n\n"
#define STR_ERR_CHAR_INVALID "\n\tcharacter argument is invalid.\n\n"
#define STR_ERR_SAY_INVALID_CHAR "\n\tInvalid char in string, skipping ...\n\n"
#define STR_ERR_PATTERN_INVALID "\n\tPattern argument is invalid.\n\n"
#define STR_ERR_INT_INVALID "\n\tInteger argument is invalid.\n\n"

// EC
#define STR_COMMAND_USAGE_EC \
  "\nBit ops:\n" \
  "\tset    part0 part1 -- Turns pixels on where part0/part1 bits are 1.\n" \
  "\tclear  part0 part1 -- Turns pixels off where part0/part1 bits are 1.\n" \
  "\ttoggle part0 part1 -- Flips pixels where part0/part1 bits are 1.\n" \
  "\tinvert             -- Flips all pixels in the image.\n" \
  "Strings:\n" \
  "\tcharacter c -- Sets the character c into the image.\n" \
  "\t               Allowed characters: A-Z, a-z, 0-9.\n" \
  "\tsay str     -- Displays characters from str as a sequence of images.\n" \
  "Movement:\n" \
  "\tscrollHorizontal offset   -- Scrolls image horizontally.\n" \
  "\t                               positive offset scrolls right\n" \
  "\t                               negative offset scrolls left\n" \
  "\tscrollVertical offset     -- Scrolls image vertically.\n" \
  "\t                               positive offset scrolls down\n" \
  "\t                               negative offset scrolls up\n" \
  "\ttranslate offsetH offsetV -- Scrolls image offsetH horizontally and\n" \
  "\t                             offsetV vertically.\n" \
  "\tmirrorHorizontal          -- Mirror/flip image horizontally.\n" \
  "\tmirrorVertical            -- Mirror/flip image vertically.\n" \
  "\trotateClockwise           -- Rotate image 90 degrees clockwise.\n" \
  "\trotateCounterClockwise    -- Rotate image 90 degrees counter\n" \
  "\t                             clockwise.\n" \
  "\ttranspose                 -- Transpose image with y=-x as diagonal.\n" \
  "Misc:\n" \
  "\thelp -- Shows this help message.\n" \
  "\n" \
  "Press Ctrl + D to exit.\n\n"

#endif // PA2_STRINGS_H
