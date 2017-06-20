package com.nasmlanguage;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;

import static com.intellij.psi.TokenType.BAD_CHARACTER;
import static com.intellij.psi.TokenType.WHITE_SPACE;
import static com.nasmlanguage.psi.NASMTypes.*;

%%

%{
  public _NASMLexer() {
    this((java.io.Reader)null);
  }
%}

%public
%class _NASMLexer
%implements FlexLexer
%function advance
%type IElementType
%unicode

EOL=\R
WHITE_SPACE=\s+

CRLF=\r|\n|\r\n
WHITE_SPACE=[ \t\x0B\f]+
COMMENT=(;.*?(\r|\n|\r\n)?)
EQU=([eE][qQ][uU])
STRUC_TAG=([sS][tT][rR][uU][cC])
ENDSTRUC_TAG=([eE][nN][dD][sS][tT][rR][uU][cC])
ISTRUC_TAG=([iI][sS][tT][rR][uU][cC])
IEND_TAG=([iI][eE][nN][dD])
AT_TAG=([aA][tT])
INCLUDE_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([iI][nN][cC][lL][uU][dD][eE])
DEFINE_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)(([xX]|[iI])?[dD][eE][fF][iI][nN][eE])
ASSIGN_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([iI]?[aA][sS][sS][iI][gG][nN])
MACRO_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([iI]?[mM][aA][cC][rR][oO])
MACRO_END_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([iI]?[eE][nN][dD][mM][aA][cC][rR][oO])
MACRO_PARAM_REF=((%|%%)([1-9][0-9]*))
MACRO_LBL_DEF=((%|%%)([a-zA-Z0-9$._?][a-zA-Z0-9$._?#@\126]*):)
MACRO_VAR_REF=((%|%%)([a-zA-Z0-9$._?][a-zA-Z0-9$._?#@\126]*))
IF_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([iI][fF][nN]?([dD][eE][fF])?)
IFMACRO_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([iI][fF][mM][aA][cC][rR][oO])
IFCTX_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([iI][fF][cC][tT][xX])
ELIF_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([eE][lL][iI][fF][nN]?([dD][eE][fF])?)
ELSE_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([eE][lL][sS][eE])
ENDIF_TAG=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([eE][nN][dD][iI][fF])
STRLEN_TAG=((({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([sS][tT][rR][lL][eE][nN]))
ERROR_TAG=((({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([eE][rR][rR][oO][rR])).*
SECTION_TAG=([sS][eE][cC][tT][iI][oO][nN])
CODE_SECTION_NAME=(\.[tT][eE][xX][tT])
DATA_SECTION_NAME=(\.[dD][aA][tT][aA])
BSS_SECTION_NAME=(\.[bB][sS][sS])
MAP_OPTIONS=(all|brief|sections|segments|symbols)
MAP_FILE=(([a-zA-Z_][a-zA-Z0-9_.]*).[mM][aA][pP])
DIRECTIVE_OP=[bB][iI][tT][sS]|[uU][sS][eE]16|[uU][sS][eE]32|[sS][eE][cC][tT][iI][oO][nN]|[sS][eE][gG][mM][eE][nN][tT]|[aA][bB][sS][oO][lL][uU][tT][eE]|[eE][xX][tT][eE][rR][nN]|[gG][lL][oO][bB][aA][lL]|[oO][rR][gG]|[aA][lL][iI][gG][nN]|[sS][tT][rR][uU][cC]|[eE][nN][dD][sS][tT][rR][uU][cC]|[cC][oO][mM][mM][oO][nN]|[cC][pP][uU]|[gG][rR][oO][uU][pP]|[uU][pP][pP][eE][rR][cC][aA][sS][eE]|[iI][mM][pP][oO][rR][tT]|[eE][xX][pP][oO][rR][tT]|[lL][iI][bB][rR][aA][rR][yY]|[mM][oO][dD][uU][lL][eE]
PREPROCESSOR_OP=(({WHITE_SPACE})?[#%]({WHITE_SPACE})?)([xX]?[iI]?[dD][eE][fF][iI][nN][eE]|[uU][nN][dD][eE][fF]|[aA][sS][sS][iI][gG][nN]|[iI]?[dD][eE][fF][sS][tT][rR]|[iI]?[dD][eE][fF][tT][oO][kK]|[sS][tT][rR][cC][aA][tT]|[sS][tT][rR][lL][eE][nN]|[sS][uU][bB][sS][tT][rR]|[iI]?[mM][aA][cC][rR][oO]|[eE][nN][dD][mM][aA][cC][rR][oO]|[rR][oO][tT][aA][tT][eE]|[rR][eE][pP]|[eE][nN][dD][rR][eE][pP])
DATA_OP=([rR][eE][sS][bBwWdDqQtToOyYzZ]|[dD][bBwWdDqQtToOyYzZ]|[tT][iI][mM][eE][sS])
INS_DATA_TRANS_MOV=(mov([sz]x)?|cmov(n?[abceglopsz]|n?[abgl]e|p[eo]))|(xchg|bswap|xadd|cmpxchg(8b)?)
INS_DATA_TRANS_XCHG=(xchg|bswap|xadd|cmpxchg(8b)?)
INS_DATA_TRANS_OTHER=((push|pop)(ad?)?|cwde?|cdq|cbw)
INS_DECIMAL_ARITH=(daa|das|aaa|aas|aam|aad)
INS_BINARY_ARITH=(adcx?|adox|add|sub|sbb|i?mul|i?div|inc|dec|neg|cmp)
INS_BINARY_LOGICAL=(and|x?or|not)
INS_BINARY_ROTATE=(s[ah][rl]|sh[rl]d|r[co][rl])
INS_BINARY_SET=(set(n?[abceglopsz]|n?[abgl]e|p[eo]))
INS_BINARY_OTHER=(bt[crs]?|bs[fr]|test|crc32|popcnt)
INS_CONTROL_TRANS=(jmp|jn?[abceglopsz]|jn?[abgl]e|jp[eo]|j[er]?cxz)|(loop(n?[ez])?|call|ret|retn|iret[dq]?|into?|bound|enter|leave)
INS_STRING_DATA=((mov|cmp|sca|lod|sto)(s[bdw]?)|rep(n?[ez])?)
INS_INPUT_OUTPUT=((in|out)(s[bdw]?)?)
INS_FLAG_CONTROL=((st|cl)[cdi]|cmc|[ls]ahf|(push|pop)f[dq]?)
INS_SEG_REGS=(l[defgs]s)
INS_MISC_OTHER=(lea|nop|ud2|xlatb?|cpuid|movbe)
INS_RNG_RAND=(rdrand|rdseed)
INS_BIT_MANIPULATION=(andn|bextr|bls(i|r|msk)|bzhi|pdep|pext|[lt]zcnt|(mul|ror|sar|shl|shr)x)
INS_64_BIT=(cdqe|cqo|(cmp|lod|mov|sto)sq|cmpxchg16b|mov(ntq|sxd)|scasq|swapgs|sys(call|ret))
INS_FPU_DATA_TRANS=(fcmov(n?([beu]|be)))|(f(i?(ld|stp?)|b(ld|stp)|xch))
INS_FPU_BASIC_ARITH=(f((add|div|mul|sub)p?|i(add|div|mul|sub)|(div|sub)rp?|i(div|sub)r))|(f(prem1?|abs|chs|rndint|scale|sqrt|xtract))
INS_FPU_COMPARISON=(f(u?com[ip]?p?|icomp?|tst|xam))
INS_FPU_TRANSCEND=(f(sin|cos|sincos|pa?tan|2xm1|yl2x(p1)?))
INS_FPU_LOAD=(fld(1|z|pi|l2[et]|l[ng]2))
INS_FPU_CONTROL=(f((inc|dec)stp|free|n?(init|clex|st[cs]w|stenv|save)|ld(cw|env)|rstor|nop)|f?wait)
INS_FPU_STATE=(fx(save|rstor)(64)?)
INS_MMX_DATA_TRANS=(mov[dq])
INS_MMX_CONVERSION=(pack(ssdw|[su]swb)|punpck[hl](bw|dq|wd))
INS_MMX_ARITH=(p(((add|sub)(d|(u?s)?[bw]))|maddwd|mul[lh]w))
INS_MMX_COMPARISON=(pcmp((eq|gt)[bdw]))
INS_MMX_LOGICAL=(pandn?|px?or)
INS_MMX_ROTATE=(ps([rl]l[dwq]|raw|rad))
INS_MMX_STATE=(emms)
INS_SSE_DATA_TRANS=(mov(([ahlu]|hl|lh|msk)ps|ss))
INS_SSE_ARITH=((add|div|max|min|mul|rcp|r?sqrt|sub)[ps]s)
INS_SSE_COMPARISON=(cmp[ps]s|u?comiss)
INS_SSE_LOGICAL=((andn?|x?or)ps)
INS_SSE_OTHER=((shuf|unpck[hl])ps)
INS_SSE_CONVERSION=(cvt(pi2ps|si2ss|ps2pi|tps2pi|ss2si|tss2si))
INS_SSE_STATE=((ld|st)mxcsr)
INS_SSE_SIMD_INT=(p(avg[bw]|extrw|insrw|(max|min)(sw|ub)|sadbw|shufw|mulhuw|movmskb))
INS_SSE_CACHE_CTRL=(maskmovq|movntps|sfence)
INS_SSE_PREFETCH=(prefetch(nta|t[0-2]|w(t1)?))
INS_SSE2_DATA_TRANS=(mov([auhl]|msk)pd)
INS_SSE2_ARITH=((add|div|max|min|mul|sub|sqrt)[ps]d)
INS_SSE2_LOGICAL=((andn?|x?or)pd)
INS_SSE2_COMPARISON=((cmpp|u?comis)d)
INS_SSE2_OTHER=((shuf|unpck[hl])pd)
INS_SSE2_CONVERSION=(cvt(dq2pd|pi2pd|ps2pd|pd2ps|si2sd|sd2ss|ss2sd|t?(pd2dq|pd2pi|sd2si)))|(cvt(dq2ps|ps2dq|tps2dq))
INS_SSE2_SIMD_INT=(mov(dq[au]|q2dq|dq2q))|(p((add|sub|(s[lr]l|mulu|unpck[hl]q)d)q|shuf(d|[hl]w)))
INS_SSE2_CACHE_CTRL=(clflush|[lm]fence|pause|maskmovdqu|movnt(dq|i|pd))
INS_SSE3_GENERAL=(fisttp|lddqu|(addsub|h(add|sub))p[sd]|mov(sh|sl|d)dup|monitor|mwait)
INS_SSE3_ARITH=(ph(add|sub)(s?w|d))
INS_SSE3_OTHER=(p((abs|sign)[bdw]|maddubsw|mulhrsw|shufb|alignr))
INS_SSE4_ARITH=(pmul(ld|dq)|dpp[ds])
INS_SSE4_DATA_TRANS=(movntdqa)
INS_SSE4_BLEND=(blendv?p[ds]|pblend(vb|w))
INS_SSE4_PACKED_INT=(p(min|max)(u[dw]|s[bd]))
INS_SSE4_PACKED_FP=(round[ps][sd])
INS_SSE4_INS_EXT=((extract|insert)ps|p((ins|ext)(r[bdq])))
INS_SSE4_CONVERSION=(pmov([sz]x(b[dqw]|dq|wd|wq)))
INS_SSE4_OTHER=(mpsadbw|phminposuw|ptest|pcmpeqq|packusdw)|(pcmp([ei]str[im]|gtq))
OP_PREFIX=((rep(n?[ez])|rep)|lock)
GENERAL_OP={INS_DATA_TRANS_MOV}|{INS_DATA_TRANS_XCHG}|{INS_DATA_TRANS_OTHER}|{INS_DECIMAL_ARITH}|{INS_BINARY_ARITH}|{INS_BINARY_LOGICAL}|{INS_BINARY_ROTATE}|{INS_BINARY_SET}|{INS_BINARY_OTHER}|{INS_CONTROL_TRANS}|{INS_STRING_DATA}|{INS_INPUT_OUTPUT}|{INS_FLAG_CONTROL}|{INS_SEG_REGS}|{INS_MISC_OTHER}|{INS_RNG_RAND}|{INS_BIT_MANIPULATION}
X64_OP={INS_64_BIT}
FPU_OP={INS_FPU_DATA_TRANS}|{INS_FPU_BASIC_ARITH}|{INS_FPU_COMPARISON}|{INS_FPU_TRANSCEND}|{INS_FPU_LOAD}|{INS_FPU_CONTROL}|{INS_FPU_STATE}
MMX_OP={INS_MMX_DATA_TRANS}|{INS_MMX_CONVERSION}|{INS_MMX_ARITH}|{INS_MMX_COMPARISON}|{INS_MMX_LOGICAL}|{INS_MMX_ROTATE}|{INS_MMX_STATE}
SSE_OP={INS_SSE_DATA_TRANS}|{INS_SSE_ARITH}|{INS_SSE_COMPARISON}|{INS_SSE_LOGICAL}|{INS_SSE_OTHER}|{INS_SSE_CONVERSION}|{INS_SSE_STATE}|{INS_SSE_SIMD_INT}|{INS_SSE_CACHE_CTRL}|{INS_SSE_PREFETCH}
SSE2_OP={INS_SSE2_DATA_TRANS}|{INS_SSE2_ARITH}|{INS_SSE2_LOGICAL}|{INS_SSE2_COMPARISON}|{INS_SSE2_OTHER}|{INS_SSE2_CONVERSION}|{INS_SSE2_SIMD_INT}|{INS_SSE2_CACHE_CTRL}
SSE3_OP={INS_SSE3_GENERAL}|{INS_SSE3_ARITH}|{INS_SSE3_OTHER}
SSE4_OP={INS_SSE4_ARITH}|{INS_SSE4_DATA_TRANS}|{INS_SSE4_BLEND}|{INS_SSE4_PACKED_INT}|{INS_SSE4_PACKED_FP}|{INS_SSE4_INS_EXT}|{INS_SSE4_CONVERSION}|{INS_SSE4_OTHER}
REGISTER=%?(([abcd][hl])|([er]?[abcd]x)|([er]?[sb]p)|([er]?[sd]i|dil|sil|bpl|spl)|([er]?ip)|(r(8|9|1[0-5])[bdlw]?)|([er]?flags)|(cr[02348])|(dr[012367])|(tr[34567])|(([gil]dt)r?|tr)|(bnd([0-3]|cfg[su]|status))|((mm|st|fpr)[0-7])|([xy]mm([0-9]|1[0-5])|mxcsr))
SEGMENT=([c-gs]s)
SIZE_TYPE=[sS][hH][oO][rR][tT]|[lL][oO][nN][gG]|(((([dDqQoOtTyYzZ]|[xX][mM][mM])?[wW][oO][rR][dD])|[bB][yY][tT][eE])(([ \t\x0B\f]+)[pP][tT][rR])?)
ID=[a-zA-Z_][a-zA-Z0-9_]*
LBL_DEF=[a-zA-Z$._?][a-zA-Z0-9$._?#@\126]*:
LBL=[a-zA-Z$._?][a-zA-Z0-9$._?#@\126]*
BINARY=(0[bB][0-1]+|0[yY][0-1]+|[0-1][0-1]*[bB]|[0-1][0-1]*[yY])
HEXADECIMAL=(0[xX][0-9a-fA-F]+|0[hH][0-9a-fA-F]+|\$[0-9]+[0-9a-fA-F]*|[0-9]+[0-9a-fA-F]*[hH])
DECIMAL=((([1-9][0-9]*\.?[0-9]*)|(\.[0-9]+))([Ee][+-]?[0-9]+)?|0[dD][0-9]+|[0-9]+)
CHARACTER=('([^'\\]|\\.)')
STRING=('([^'\\]|\\.)*'|\"([^\"\\]|\\.)*\")

%%
<YYINITIAL> {
  {WHITE_SPACE}               { return WHITE_SPACE; }

  ":"                         { return COLON; }
  ";"                         { return SEMICOLON; }
  "["                         { return SQUARE_L; }
  "]"                         { return SQUARE_R; }
  "("                         { return ROUND_L; }
  ")"                         { return ROUND_R; }
  ","                         { return SEPARATOR; }
  "."                         { return DOT; }
  "?"                         { return QUESTION; }
  "="                         { return EQUAL; }
  "=="                        { return EQUALEQUAL; }
  "+"                         { return PLUS; }
  "-"                         { return MINUS; }
  "*"                         { return TIMES; }
  "/"                         { return DIVIDE; }
  "$"                         { return DOLLARSIGN; }
  "$$"                        { return DOLLARSIGN2; }
  "%"                         { return PERCENT; }
  "%%"                        { return PERCENT2; }

  {CRLF}                      { return CRLF; }
  {WHITE_SPACE}               { return WHITE_SPACE; }
  {COMMENT}                   { return COMMENT; }
  {EQU}                       { return EQU; }
  {STRUC_TAG}                 { return STRUC_TAG; }
  {ENDSTRUC_TAG}              { return ENDSTRUC_TAG; }
  {ISTRUC_TAG}                { return ISTRUC_TAG; }
  {IEND_TAG}                  { return IEND_TAG; }
  {AT_TAG}                    { return AT_TAG; }
  {INCLUDE_TAG}               { return INCLUDE_TAG; }
  {DEFINE_TAG}                { return DEFINE_TAG; }
  {ASSIGN_TAG}                { return ASSIGN_TAG; }
  {MACRO_TAG}                 { return MACRO_TAG; }
  {MACRO_END_TAG}             { return MACRO_END_TAG; }
  {MACRO_PARAM_REF}           { return MACRO_PARAM_REF; }
  {MACRO_LBL_DEF}             { return MACRO_LBL_DEF; }
  {MACRO_VAR_REF}             { return MACRO_VAR_REF; }
  {IF_TAG}                    { return IF_TAG; }
  {IFMACRO_TAG}               { return IFMACRO_TAG; }
  {IFCTX_TAG}                 { return IFCTX_TAG; }
  {ELIF_TAG}                  { return ELIF_TAG; }
  {ELSE_TAG}                  { return ELSE_TAG; }
  {ENDIF_TAG}                 { return ENDIF_TAG; }
  {STRLEN_TAG}                { return STRLEN_TAG; }
  {ERROR_TAG}                 { return ERROR_TAG; }
  {SECTION_TAG}               { return SECTION_TAG; }
  {CODE_SECTION_NAME}         { return CODE_SECTION_NAME; }
  {DATA_SECTION_NAME}         { return DATA_SECTION_NAME; }
  {BSS_SECTION_NAME}          { return BSS_SECTION_NAME; }
  {MAP_OPTIONS}               { return MAP_OPTIONS; }
  {MAP_FILE}                  { return MAP_FILE; }
  {DIRECTIVE_OP}              { return DIRECTIVE_OP; }
  {PREPROCESSOR_OP}           { return PREPROCESSOR_OP; }
  {DATA_OP}                   { return DATA_OP; }

  {OP_PREFIX}                 { return OP_PREFIX; }
  {GENERAL_OP}                { return GENERAL_OP; }
  {X64_OP}                    { return X64_OP; }
  {FPU_OP}                    { return FPU_OP; }
  {MMX_OP}                    { return MMX_OP; }
  {SSE_OP}                    { return SSE_OP; }
  {SSE2_OP}                   { return SSE2_OP; }
  {SSE3_OP}                   { return SSE3_OP; }
  {SSE4_OP}                   { return SSE4_OP; }
  {REGISTER}                  { return REGISTER; }
  {SEGMENT}                   { return SEGMENT; }
  {SIZE_TYPE}                 { return SIZE_TYPE; }
  {ID}                        { return ID; }
  {LBL_DEF}                   { return LBL_DEF; }
  {LBL}                       { return LBL; }
  {BINARY}                    { return BINARY; }
  {HEXADECIMAL}               { return HEXADECIMAL; }
  {DECIMAL}                   { return DECIMAL; }
  {CHARACTER}                 { return CHARACTER; }
  {STRING}                    { return STRING; }

}

[^] { return BAD_CHARACTER; }
