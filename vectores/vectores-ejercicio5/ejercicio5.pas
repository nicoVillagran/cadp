{
    Utilizando los módulos implementados en el ejercicio 4, realizar un programa que lea números enteros
    desde teclado (a lo sumo 100) y los almacene en un vector. La carga finaliza al leer el número 0 (que no
    debe procesarse). Al finalizar la carga, se debe intercambiar la posición del mayor elemento por la del
    menor elemento, e informe la operación realizada de la siguiente manera: “El elemento máximo ... que
    se encontraba en la posición ... fue intercambiado con el elemento mínimo ... que se encontraba en la
    posición ...”

    - modulo leer numero.
    
    modulo: agregar a vector.
     datos de entrada:
        - numero: integer
        - v: vector
        - dimL: integer
        - agreado: boolean
    datos de salida:
        - v: vector
        - dimL: integer
    
    condiciones:
    - si (dimL + 1 <= dimF) entonces
        - dimL := dimL + 1
        - v[dimL] := numero
        - agregado := true
    sino entonces
        - agregado := false

    - modulo cargar vector.
     datos de entrada:
        - v: vector
        - dimL: integer
    datos de salida:
        - v: vector
    
    inicialización:
        - dimL := 0
        - agregado := true
    condiciones:
    - leer numero
    - mientras (numero <> 0) y (agregado) hacer
        - agregar a vector
        - leer numero
    fin mientras.

    - encontrar posicion del mayor elemento.
    - encontrar posicion del menor elemento.
    - modulo intercambiar posiciones.

    estructura de control: while.
    condicion de corte: numero ingresado es igual a 0. (no se procesa el 0).

    condiciones:
    - leer numero    
    - mientras (numero ingresado <> 0) y (cantidad de numeros ingresados < 100) hacer
        - agregar a vector
        - leer numero
    fin mientras.

    orden del programa:
    - definir dimension fisica del vector (dimF).
    - definir dimension logica del vector (dimL).
    - definir vector (V).
    - leer numero
    - mientras (numero <> 0) y (dimL < dimF) hacer
        - agregar a vector
        - leer numero
    - fin mientras.
    - encontrar posicion del mayor elemento.
    - guardar valor del mayor elemento y su posicion.
    - encontrar posicion del menor elemento.
    - guardar valor del menor elemento y su posicion.
    - intercambiar posiciones.
    - informar resultado.
-------------------------------------

    10, 5, 25, 2, 8, 0
}

program ejercicio5;
const dimF = 6;
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
// Módulo: elementoMaximo
function elementoMaximo(v: vector; dimL: integer): integer;
    var
        i, max, posicionMax: integer;
    begin
        max := v[1];
        posicionMax := 1;
        for i := 2 to dimL do
        begin
            if v[i] > max then
            begin
                max := v[i];
                posicionMax := i;
            end;
        end;
        elementoMaximo := posicionMax;
    end;

// Módulo: elementoMinimo
function elementoMinimo(v: vector; dimL: integer): integer;
    var
        i, min, posicionMin: integer;
    begin
        min := v[1];
        posicionMin := 1;
        for i := 2 to dimL do
        begin
            if v[i] < min then
            begin
                min := v[i];
                posicionMin := i;
            end;
        end;
        elementoMinimo := posicionMin;
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
        posMax := elementoMaximo(v, dimL);
        posMin := elementoMinimo(v, dimL);
        intercambio(posMax, posMin, v);
        writeln('El elemento maximo ', v[posMin], ' que se encontraba en la posicion ', posMax, ' fue intercambiado con el elemento minimo ', v[posMax], ' que se encontraba en la posicion ', posMin);
    end
    else
        writeln('No se ingresaron numeros.');
end.
