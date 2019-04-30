/*
 * Filename: pa2.h
 * Author: TODO
 * UserId: TODO
 * Date: TODO
 * Sources of help: Given.
 */
#ifndef PA2_H
#define PA2_H

// -----------------------------------------------------------------------------
// Program constants
// -----------------------------------------------------------------------------

// Arg parsing
#define MIN_EXPECTED_ARGS 0
#define MAX_EXPECTED_ARGS 2
#define PROG_NAME_IDX 0
#define ON_CHAR_IDX 1
#define OFF_CHAR_IDX 2 

#define DEFAULT_ON_CHAR '@'
#define DEFAULT_OFF_CHAR '-'

#define MIN_ASCII ' '
#define MAX_ASCII '~'

#define ON_ARG_NAME "on"
#define OFF_ARG_NAME "off"

#define HALF_PATTERN_STR_LEN 32
#define PATTERN_STR_LEN 64

// String tokenizing and int parsing
#define DELIM " "
#define PATTERN_BASE 0
#define OFFSET_BASE 10

// Constants about the pattern/image
#define BYTE_BITWIDTH 8
#define INT_BITWIDTH (sizeof(unsigned int) * BYTE_BITWIDTH)
#define HALF_PATTERN_LEN 4

#define PATTERN_LEN 2
#define PATTERN_BITWIDTH (INT_BITWIDTH * PATTERN_LEN)
#define HALF_PATTERN_BITWIDTH (PATTERN_BITWIDTH / 2)

#define IMAGE_HEIGHT (PATTERN_BITWIDTH / BYTE_BITWIDTH)

// Masks and bit ops
#define MSB_MASK 0xFF000000
#define LSB_MASK 0x000000FF

// Commands
#define COMMANDS \
  { "set", "clear", "toggle", "invert", \
    "character", "say", \
    "scrollHorizontal", "scrollVertical", "translate", "help", NULL }

#define SET 0
#define CLEAR 1
#define TOGGLE 2
#define INVERT 3
#define CHARACTER 4
#define SAY 5
#define SCROLL_HORIZONTAL 6
#define SCROLL_VERTICAL 7
#define TRANSLATE 8
#define HELP 9

// EC Constants
#define EC_COMMANDS \
  { "set", "clear", "toggle", "invert", \
    "character", "say", \
    "scrollHorizontal", "scrollVertical", "translate", "help", \
    "mirrorHorizontal", "mirrorVertical", "rotateClockwise", \
    "rotateCounterClockwise", "transpose", NULL }

#define MIRROR_HORIZONTAL 10
#define MIRROR_VERTICAL 11
#define ROTATE_CLOCKWISE 12
#define ROTATE_COUNTERCLOCKWISE 13
#define TRANSPOSE 14

// Pattern arrays (use in character() with loadPatternString())
#define DIGIT_PATTERNS { \
  /* 0 */ "----------@@@@---@---@@--@--@-@--@-@--@--@@---@---@@@@----------", \
  /* 1 */ "-----------@@-----@@@----@-@@------@@------@@----@@@@@@---------", \
  /* 2 */ "----------@@@@---@----@-------@---@@@@---@-------@@@@@@---------", \
  /* 3 */ "----------@@@@---@----@-----@@--------@--@----@---@@@@----------", \
  /* 4 */ "-------------@------@@-----@-@----@--@---@@@@@@------@----------", \
  /* 5 */ "---------@@@@@@--@-------@@@@@--------@--@----@---@@@@----------", \
  /* 6 */ "----------@@@@---@-------@@@@@---@----@--@----@---@@@@----------", \
  /* 7 */ "---------@@@@@@-------@------@------@------@-------@------------", \
  /* 8 */ "----------@@@@---@----@---@@@@---@----@--@----@---@@@@----------", \
  /* 9 */ "----------@@@@---@----@--@----@---@@@@@-------@---@@@@----------"  \
}

#define ALPHABET_PATTERNS { \
  /* A */ "---------@@@@@@--@----@--@----@--@@@@@@--@----@--@----@---------", \
  /* B */ "---------@@@@@---@----@--@@@@@---@----@--@----@--@@@@@----------", \
  /* C */ "----------@@@@---@----@--@-------@-------@----@---@@@@----------", \
  /* D */ "---------@@@@----@---@---@----@--@----@--@---@---@@@@-----------", \
  /* E */ "---------@@@@@@--@-------@@@@@---@-------@-------@@@@@@---------", \
  /* F */ "---------@@@@@@--@-------@@@@----@-------@-------@--------------", \
  /* G */ "----------@@@@---@-------@-------@--@@@--@----@---@@@@----------", \
  /* H */ "---------@----@--@----@--@@@@@@--@----@--@----@--@----@---------", \
  /* I */ "---------@@@@@@----@@------@@------@@------@@----@@@@@@---------", \
  /* J */ "------------@@@------@-------@---@---@---@---@----@@@-----------", \
  /* K */ "---------@---@---@--@----@@@-----@--@----@---@---@----@---------", \
  /* L */ "---------@-------@-------@-------@-------@-------@@@@@@---------", \
  /* M */ "---------@----@--@@--@@--@-@@-@--@----@--@----@--@----@---------", \
  /* N */ "---------@----@--@@---@--@-@--@--@--@-@--@---@@--@----@---------", \
  /* O */ "----------@@@@---@----@--@----@--@----@--@----@---@@@@----------", \
  /* P */ "---------@@@@@---@----@--@----@--@@@@@---@-------@--------------", \
  /* Q */ "----------@@@@---@----@--@----@--@--@-@--@---@@---@@@@----------", \
  /* R */ "---------@@@@@---@----@--@----@--@@@@@---@---@---@----@---------", \
  /* S */ "----------@@@@@--@--------@@@@--------@-------@--@@@@@----------", \
  /* T */ "---------@@@@@@----@@------@@------@@------@@------@@-----------", \
  /* U */ "---------@----@--@----@--@----@--@----@--@----@---@@@@----------", \
  /* V */ "---------@----@--@----@--@----@--@----@---@--@-----@@-----------", \
  /* W */ "---------@----@--@----@--@----@--@----@--@-@@-@---@--@----------", \
  /* X */ "---------@----@---@--@-----@@------@@-----@--@---@----@---------", \
  /* Y */ "---------@----@---@--@-----@@------@@------@@------@@-----------", \
  /* Z */ "---------@@@@@@------@------@------@------@------@@@@@@---------"  \
}

// This is a bit of a magic macro which will print the prompt ">>> " only
// if input is coming from terminal.
// In other cases (e.g. file redirected input), no prompt is printed.
#define PRINT_PROMPT (shouldPrompt() ? printf(STR_COMMAND_PROMPT) : 0)

// -----------------------------------------------------------------------------
// Function prototypes (DO NOT EDIT)
// -----------------------------------------------------------------------------
void outputChar( char ch );
int intervalContains( int start, int end, int value );
int myRem( int dividend, int divisor );
int shouldPrompt( void );

void set( unsigned int pattern[], unsigned int part0,
          unsigned int part1 );
void clear( unsigned int pattern[], unsigned int part0,
            unsigned int part1 );
void toggle( unsigned int pattern[], unsigned int part0,
             unsigned int part1 );

void loadPatternString( unsigned int pattern[], const char * patternStr );
int character( unsigned int pattern[], char ch, 
               const char * alphabetPatterns[], const char * digitPatterns[] );
void scrollHorizontal( unsigned int pattern[], int offset );
void scrollVertical( unsigned int pattern[], int offset );
int findCommand( const char * cmdString, const char * commands[] );

void invert( unsigned int pattern[] );
void say( const char * str, char on, char off );
void translate( unsigned int pattern[], int hOffset, int vOffset );

void printPattern( unsigned int pattern[], char on, char off );
void commandLoop( char on, char off );

// EC
void mirrorVertical( unsigned int pattern[] );
void mirrorHorizontal( unsigned int pattern[] );
void transpose( unsigned int pattern[] );
void rotateClockwise( unsigned int pattern[] );
void rotateCounterClockwise( unsigned int pattern[] );

#endif // PA2_H
