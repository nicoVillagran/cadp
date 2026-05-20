{
    Dado que en la solución anterior se recorre dos veces el vector (una para calcular el elemento máximo
    y otra para el mínimo), implementar un único módulo que recorra una única vez el vector y devuelva
    ambas posiciones.

    modulo MaxMin:
    datos de entrada:
    - vector de enteros
    - dimension logica (dimL)
    - posicion del maximo
    - posicion del minimo

    datos de salida:
    - posicion del maximo
    - posicion del minimo

    inicializacion:
    - max := v[1]
    - min := v[1]
    - posicion del maximo = 1
    - posicion del minimo = 1

    condiciones:
    - para i desde 2 hasta dimL hacer
        - si v[i] > max entonces
            - max := v[i]
            - posicionMax := i
        - si v[i] < min entonces
            - min := v[i]
            - posicionMin := i
-------------------------------------

    10, 5, 25, 2, 8, 0
}

program ejercicio6;
const
    dimF = 6;
type
    vector = array [1..dimF] of integer;
// Módulo: intercambio
procedure intercambio(x, y: integer; var v: vector);
    var
        temp: integer;
    begin
        temp := v[x];
        v[x] := v[y];
        v[y] := temp;
    end;
// modulo: maximo-minimo
procedure MaxMin(v: vector; dimL: integer; var posicionMax: integer; var posicionMin: integer);
    var
        max: integer;
        min: integer;
        i: integer;
    begin
        max := v[1];
        min := v[1];
        posicionMax := 1;
        posicionMin := 1;
        for i := 2 to dimL do
        begin
            if v[i] > max then
            begin
                max := v[i];
                posicionMax := i;
            end;
            if v[i] < min then
            begin
                min := v[i];
                posicionMin := i;
            end;
        end;
    end;
// Módulo: agregar a vector
procedure agregarAVector(numero: integer; var v: vector; var dimL: integer; var agregado: boolean);
    begin
        if (dimL + 1 <= dimF) then
        begin
            dimL := dimL + 1;
            v[dimL] := numero;
            agregado := true;
        end
        else
            agregado := false;
    end;
// Módulo: cargar vector
procedure cargarVector(var v: vector; var dimL: integer);
    var
        numero: integer;
        agregado: boolean;
    begin
        agregado := true;
        write('Ingrese un numero (0 para finalizar): ');
        readln(numero);
        while (numero <> 0) and (agregado) do
        begin
            agregarAVector(numero, v, dimL, agregado);
            if agregado then
            begin
                write('Ingrese un numero (0 para finalizar): ');
                readln(numero);
            end
            else
                writeln('No se pueden ingresar mas numeros. Vector lleno.');
        end;
    end;

var
    v: vector;
    dimL, posMax, posMin: integer;
begin
    dimL := 0;
    cargarVector(v, dimL);
    if dimL > 0 then
    begin
        MaxMin(v, dimL, posMax, posMin);
        intercambio(posMax, posMin, v);
        writeln('El elemento maximo ', v[posMin], ' que se encontraba en la posicion ', posMax, ' fue intercambiado con el elemento minimo ', v[posMax], ' que se encontraba en la posicion ', posMin);
    end
    else
        writeln('No se ingresaron numeros.');
end.