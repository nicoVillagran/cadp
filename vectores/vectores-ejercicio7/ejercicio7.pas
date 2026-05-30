{
    Realizar un programa que lea números enteros desde teclado hasta que se ingrese el valor -1 (que no debe procesarse)
    e informe:
        a. La cantidad de ocurrencias de cada dígito procesado.
        b. El dígito más leído.
        c. Los dígitos que no tuvieron ocurrencias.

    Por ejemplo: si la secuencia que se lee es: 63 34 99 94 96 -1, el programa deberá informar:
        Número 3: 2 veces
        Número 4: 2 veces
        Número 6: 2 veces
        Número 9: 4 veces
    El dígito más leído fue el 9.b
    Los dígitos que no tuvieron ocurrencias son: 0, 1, 2, 5, 7, 8.
------------------------------------------------------------
    a. modulo contarOcurrencias:
        - datos entrada:
            - numero: entero
            - v: vector digitos
        - datos salida:
            - v: vector digitos
        
        inicializaciones:
            - digito: entero
        
        condiciones
        mientras numero <> 0 hacer
            digito <- numero MOD 10
            v[digito] <- v[digito] + 1
            numero <- numero DIV 10
        fin mientras

    b. modulo encontrarMaximo (importat modulo..)

    c. modulo mostrarDigitosSinOcurrencias:
        - datos entrada:
            - v: vector digitos
        - datos salida:
            - ninguno
        
        condiciones
        para i <- 0 hasta 9 hacer
            si v[i] = 0 entonces
                mostrar i
            fin si
        fin para
    
    num DIV 10 -> saca el ultimo digito del numero
    num MOD 10 -> guarda el ultimo digito del numero
}

program ejercicio7;
const
    dimF = 9;
type
    vectorDigitos = array[0..dimF] of integer;
// modulo contarOcurrencias
procedure contarOcurrencias(numero: integer; var v: vectorDigitos);
    var
        digito: integer;
    begin
        digito := 0;
        while numero <> 0 do
        begin
            digito := numero mod 10;
            v[digito] := v[digito] + 1;
            numero := numero div 10;
        end;
    end;
// Módulo: elementoMaximo
function elementoMaximo(v: vectorDigitos): integer;
    var
        i, max, posicionMax: integer;
    begin
        max := v[1];
        posicionMax := 1;
        for i := 2 to dimF do
        begin
            if v[i] > max then
            begin
                max := v[i];
                posicionMax := i;
            end;
        end;
        elementoMaximo := posicionMax;
    end;
// Módulo: mostrarDigitosSinOcurrencias
procedure mostrarDigitosSinOcurrencias(v: vectorDigitos);
    var
        i: integer;
    begin
        Write('Los digitos que no tuvieron ocurrencias son:');
        for i := 0 to dimF do
        begin
            if v[i] = 0 then
                write(' ',i,',');
        end;
    end;
procedure mostrarOcurrencias(v: vectorDigitos);
    var
        i: integer;
    begin
        for i := 0 to 9 do
        begin
            if v[i] > 0 then
                writeln('Numero ', i, ': ', v[i], ' veces');
        end;
    end;

var
    v: vectorDigitos;
    num, maxOcurrencias, i: integer;
begin
    for i := 0 to dimF do
        v[i] := 0;
    write('Ingrese un numero (finalice con -1):');
    read(num);
    while num <> -1 do
    begin
        contarOcurrencias(num, v);
        write('Ingrese otro numero (finalice con -1): ');
        read(num);
    end;
    mostrarOcurrencias(v);
    maxOcurrencias := elementoMaximo(v);
    writeln('El digito mas leido fue el ', maxOcurrencias);
    mostrarDigitosSinOcurrencias(v);
end.