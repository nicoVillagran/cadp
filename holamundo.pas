
program holamundo;
type
	puntero = ^integer; 
var
	num:puntero;
begin
	new(num);
	

	writeln('ingrese un numero: ');
	readln(num^);

	writeln(num^);

	//writeln('el numero ingresado es: ', num);
end.
