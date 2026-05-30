Program pruebas;
type
   puntero = ^char;
var
  p1, p2: puntero;
begin
  new(p1);
  p1^:= 'a';
  p2:= p1;
  dispose(p2);
  write(p1^);
end.