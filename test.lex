class Yytoken {
  String token;
  int value;
  double doubleValue;
  String name;

  Yytoken (String token) {
    this.token = token;
  }

  Yytoken (String token, int value) {
    this.token=token;
    this.value=value;
  }

 Yytoken (String token, double doubleValue) {
    this.token=token;
    this.doubleValue=doubleValue;
  }
  Yytoken (String token, String name) {
    this.token=token;
    this.name=name;
  }

  String getToken() {
    return token;
  }

  int getValue() {
    return value;
  }
 
 double getDoubleValue() {
    return doubleValue;
  }

  String getName() {
    return name;
  }
}

%%

%line

%state COMMENT
%state CHRLIST

digit = [0-9]
int = {digit}+
real = ({digit}+(\.{digit}+))
chr = [a-zA-Z]
chrlist = \".*\"
identifier = {chr}({chr}|{digit})*
whitespace = [ \t\r\n\f]
boolean = [TT|FF]

%%


<YYINITIAL>"class" {return new Yytoken("CLASS");}
<YYINITIAL>"start" {return new Yytoken("START");}
<YYINITIAL>"private" {return new Yytoken("PRIVATE");}
<YYINITIAL>"public" {return new Yytoken("PUBLIC");}
<YYINITIAL>"new" {return new Yytoken("NEW");}
<YYINITIAL>"if" {return new Yytoken("IF");}
<YYINITIAL>"else" {return new Yytoken("ELSE");}
<YYINITIAL>"return" {return new Yytoken("RETURN");}
<YYINITIAL>"repeat" {return new Yytoken("REPEAT");}
<YYINITIAL>"until" {return new Yytoken("UNTIL");}
<YYINITIAL>"void" {return new Yytoken("VOID");}
<YYINITIAL>"null" {return new Yytoken("NULL");}
<YYINITIAL>"int" {return new Yytoken("INT");}
<YYINITIAL>"real" {return new Yytoken("REAL");}
<YYINITIAL>"bool" {return new Yytoken("BOOL");}
<YYINITIAL>"chrlist" {return new Yytoken("CHRLIST");}

<YYINITIAL>{int} {return new Yytoken("INTNUM", (new Integer(yytext())).intValue());}
<YYINITIAL>{real} {return new Yytoken("REALNUM", (new Double(yytext())).doubleValue());}
<YYINITIAL>"TT" {return new Yytoken("TRUE", yytext());}
<YYINITIAL>"FF" {return new Yytoken("FALSE", yytext());}
<YYINITIAL>{identifier} {return new Yytoken("ID", yytext());}
<YYINITIAL>{whitespace} {}



<YYINITIAL>":" {return new Yytoken("COLON");}
<YYINITIAL>";" {return new Yytoken("SEMI");}
<YYINITIAL>"," {return new Yytoken("COMMA");}
<YYINITIAL>"." {return new Yytoken("DOT");}

<YYINITIAL>"+" {return new Yytoken("PLUS");}
<YYINITIAL>"*" {return new Yytoken("TIMES");}
<YYINITIAL>"-" {return new Yytoken("MINUS");}
<YYINITIAL>"/" {return new Yytoken("DIVIDE");}
<YYINITIAL>"^" {return new Yytoken("POW");}

<YYINITIAL>"(" {return new Yytoken("LPAREN");}
<YYINITIAL>")" {return new Yytoken("RPAREN");}
<YYINITIAL>"{" {return new Yytoken("LBRACE");}
<YYINITIAL>"}" {return new Yytoken("RBRACE");}


<YYINITIAL>"!" {return new Yytoken("NOT");}
<YYINITIAL>"||" {return new Yytoken("OR");}
<YYINITIAL>"&&" {return new Yytoken("AND");}

<YYINITIAL>"in" {return new Yytoken("IN");}
<YYINITIAL>"not in" {return new Yytoken("NOTIN");}
<YYINITIAL>"+" {return new Yytoken("+");}

<YYINITIAL>"<" {return new Yytoken("LT");}
<YYINITIAL>"<=" {return new Yytoken("LTE");}
<YYINITIAL>">" {return new Yytoken("GT");}
<YYINITIAL>">=" {return new Yytoken("GTE");}
<YYINITIAL>"==" {return new Yytoken("EEQQ");}
<YYINITIAL>"!=" {return new Yytoken("NOTEQ");}
<YYINITIAL>"=" {return new Yytoken("EQ");}


<YYINITIAL>"length(" {yybegin(CHRLIST);}
<CHRLIST>")" {yybegin(YYINITIAL);}
<CHRLIST>{chrlist} {return new Yytoken("LENGTH");}

<YYINITIAL>{chrlist} {return new Yytoken("CHARLIST", yytext());}
<YYINITIAL>"[[" {yybegin(COMMENT);}
<COMMENT>"]]" {yybegin(YYINITIAL);}
<COMMENT>. {}
<COMMENT>{whitespace} {}
<YYINITIAL>. {System.out.println("error: unknown character " + yytext() + " found at line " + yyline);}
