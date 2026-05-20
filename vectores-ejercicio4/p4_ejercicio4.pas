{
    4. Se dispone de un vector con 100 números enteros. Implementar los siguientes módulos:
        a. posicion: dado un número X y el vector de números, retorna la posición del número X en dicho
        vector, o el valor -1 en caso de no encontrarse. ✅
        b. intercambio: recibe dos valores x e y (entre 1 y 100) y el vector de números, y retorna el mismo
        vector donde se intercambiaron los valores de las posiciones x e y. ✅
        c. sumaVector: retorna la suma de todos los elementos del vector. ✅
        d. promedio: devuelve el valor promedio de los elementos del vector. ✅
        e. elementoMaximo: retorna la posición del mayor elemento del vector. ✅
        f. elementoMinimo: retorna la posicion del menor elemento del vector. ✅

    15, 42, 8, 91, 5, 23, 91, 10


    Modulos
    a. buscarPosicion:
       datos de entrada:
        - x: integer
        - v: vector
        - encontrado: boolean
       datos de salida:
        - posicion: integer

       inicialización:
        - encontrado := false
        - posicion := -1
       
       condiciones:
        - mientras (i <= dimF) y (no encontrado) hacer
            - si v[i] = x entonces
                - encontrado := true
            - sino
                - i := i + 1
        si encontrado entonces
            - posicion := i
        si no entonces
            - posicion := -1
            
    b. intercambio:
       datos de entrada:
        - x: integer
        - y: integer
        - v: vector
       datos de salida:
        - v: vector

       inicialización:
        - temp: integer

       condiciones:
        - temp := v[x]
        - v[x] := v[y]
        - v[y] := temp
    
    c. sumaVector:
       datos de entrada:
        - v: vector
       datos de salida:
        - suma: integer

       inicialización:
        - suma := 0

       condiciones:
        - para i desde 1 hasta dimF hacer
            - suma := suma + v[i]

    d. promedio:
       datos de entrada:
        - v: vector
       datos de salida:
        - promedio: real

       inicialización:
        - suma: integer
        - promedio: real

       condiciones:
        - suma := sumaVector(v)
        - promedio := suma / dimF
    
    e. elementoMaximo:
       datos de entrada:
        - v: vector
       datos de salida:
        - posicionMax: integer

       inicialización:
        - max: integer
        - posicionMax: integer

       condiciones:
        - max := v[1]
        - posicionMax := 1
        - para i desde 2 hasta dimF hacer
            - si v[i] > max entonces
                - max := v[i]
                - posicionMax := i
    
    f. elementoMinimo:
       datos de entrada:
        - v: vector
       datos de salida:
        - posicionMin: integer

       inicialización:
        - min: integer
        - posicionMin: integer

       condiciones:
        - min := v[1]
        - posicionMin := 1
        - para i desde 2 hasta dimF hacer
            - si v[i] < min entonces
                - min := v[i]
                - posicionMin := i

    modulo cargaVector:
       datos de entrada:
        - v: vector
       datos de salida:
        - v: vector

       inicialización:
        - i: integer

       condiciones:
        - para i desde 1 hasta dimF hacer
            - v[i] := random(100) + 1.
}

program p4_ejercicio4;
const dimF = 8;
type
    vector = array [1..dimF] of integer;
// Módulo a: posición
function buscarPosicion(x: integer; v: vector): integer;
    var
        i: integer;
        encontrado: boolean;
    begin
        encontrado := false;
        i := 1;
        while (i <= dimF) and (not encontrado) do
        begin
            if v[i] = x then
                encontrado := true
            else
                i := i + 1;
        end;
        
        if encontrado then
            buscarPosicion := i
        else
            buscarPosicion := -1;
    end;

// Módulo b: intercambio
procedure intercambio(x, y: integer; var v: vector);
    var
        temp: integer;
    begin
        temp := v[x];
        v[x] := v[y];
        v[y] := temp;
    end;

// Módulo c: sumaVector
function sumaVector(v: vector): integer;
    var
        i, suma: integer;
    begin
        suma := 0;
        for i := 1 to dimF do
            suma := suma + v[i];
        sumaVector := suma;
    end;

// Módulo d: promedio
function promedio(v: vector): real;
    var
        suma: integer;
    begin
        suma := sumaVector(v);
        promedio := suma / dimF;
    end;

// Módulo e: elementoMaximo
function elementoMaximo(v: vector): integer;
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

// Módulo f: elementoMinimo
function elementoMinimo(v: vector): integer;
    var
        i, min, posicionMin: integer;
    begin
        min := v[1];
        posicionMin := 1;
        for i := 2 to dimF do
        begin
            if v[i] < min then
            begin
                min := v[i];
                posicionMin := i;
            end;
        end;
        elementoMinimo := posicionMin;
    end;

// Módulo de carga del vector
procedure cargaVector(var v: vector);
    var
        i: integer;
    begin
        for i := 1 to dimF do
            begin
                Write('Ingrese el elemento ', i, ': ');
                ReadLn(v[i]);
            end;
    end;

// modulo mostrar vector
procedure mostrarVector(v: vector);
    var
        i: integer;
    begin
        Write('Vector: ');
        for i := 1 to dimF do
            Write(v[i], ' ');
        WriteLn;
    end;

// variables locales al programa principal.
var
    v: vector;
    res: Integer;
begin
    cargaVector(v);
    // Aquí se pueden realizar pruebas de los módulos implementados
    res := elementoMinimo(v);
    WriteLn('el valor mas pequeño esta en la posicion: ', res);
    WriteLn('valor: ', v[res]);
end.