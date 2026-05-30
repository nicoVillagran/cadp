{
    Realizar un programa que lea y almacene la información de 400 alumnos ingresantes a la Facultad de
    Informática de la UNLP en el año 2020.
    De cada alumno se lee: nro de inscripción, DNI, apellido, nombre y año de nacimiento.
    Una vez leída y almacenada toda la información, calcular e informar:
        a. El porcentaje de alumnos con DNI compuesto sólo por dígitos pares.
        b. Apellido y nombre de los dos alumnos de mayor edad.

    estructura de datos:
        - fecha: registro
            - dia: entero
            - mes: entero
            - anio: entero
        - alumno: registro
            - nroInscripcion: entero
            - dni: entero
            - apellido: cadena
            - nombre: cadena
            - anioNacimiento: fecha
        - vectorAlumnos: array[1..400] of alumno
    
    Tareas divididas por responsabilidades:
        1. modulo leerAlumno
        2. modulo cargarVectorAlumnos
        3. modulo digitosPares
        5. modulo dobleMaximo
        4. modulo calcularPorcentaje
        

    
    estructura de control: for.

    1. modulo leerAlumno:
        - datos entrada:
            - alumno: registro
        - datos salida:
            - alumno: registro
        proceso
            - leer nroInscripcion, dni, apellido, nombre, anioNacimiento
    2. modulo cargarVectorAlumnos:
        - datos entrada:
            - v: vectorAlumnos
        - datos salida:
            - v: vectorAlumnos
        condiciones
            - para i <- 1 hasta 400 hacer
                leerAlumno(alumno)
                v[i] <- alumno
            fin para
    3. modulo digitosPares:
        - datos entrada:
            - numero: entero
        - datos salida:
            - resultado: booleano
        
        condiciones
            resultado <- true
            mientras (numero <> 0) y (resultado = true) hacer
                digito <- numero MOD 10
                si digito MOD 2 <> 0 entonces
                    resultado <- false
                fin si
                numero <- numero DIV 10
            fin mientras
    
    orden algoritmo:
    - declaracion de tipos
    - declaracion de variables
    - inicializacion de variables
    - cargarVectorAlumnos(vectorAlumnos)
        - leerAlumno(alumno)
    - recorrerVectorAlumnos(vectorAlumnos)
        - para i <- 1 hasta 400 hacer
            - si digitosPares(alumno.dni) entonces
                - contadorDigitosPares <- contadorDigitosPares + 1
            - dobleMaximo(alumno, aluMayor1, aluMayor2)
    - calcularPorcentaje(contadorDigitosPares, porcentaje)
    - mostrar porcentaje
    - mostrar aluMayor1.apellido, aluMayor1.nombre
    - mostrar aluMayor2.apellido, aluMayor2.nombre

    formula porcentaje:
        porcentaje <- (contadorDigitosPares * 100) / dimL.

}

program ejercicio8;
const
    dimF = 5;
type
    alumno = record
        nroInscripcion: integer;
        dni: integer;
        apellido: string;
        nombre: string;
        anioNacimiento: integer;
    end;
    vectorAlumnos = array[1..dimF] of alumno;

// modulo digitosPares
function digitosPares(numero: integer): boolean;
    var
        digito: integer;
        resultado: boolean;
    begin
        resultado := true;
        while (numero <> 0) and (resultado = true) do
        begin
            digito := numero mod 10;
            if digito mod 2 <> 0 then
                resultado := false;
            numero := numero div 10;
        end;
        digitosPares := resultado;
    end;
// modulo dobleMinimo
function dobleMinimo(v: vectorAlumnos; pos: integer; var aluMayor1, aluMayor2: integer): integer;
    var
        anio, anioMax1, anioMax2: integer;
    begin
       anio := v[pos].anioNacimiento;
       anioMax1 := v[aluMayor1].anioNacimiento;
       anioMax2 := v[aluMayor2].anioNacimiento;
       
       if anio < anioMax1 then
        begin
          aluMayor2 := aluMayor1;
          aluMayor1 := pos;
        end
        else
          if anio < anioMax2 then
            begin
              aluMayor2 := pos;
            end;
    end;
// modulo recorrerVectorAlumnos
procedure recorrerVectorAlumnos(v: vectorAlumnos; var contadorDigitosPares, aluMayor1, aluMayor2: integer);
    var
        i: integer;
    begin
        for i := 1 to dimF do
        begin
            if digitosPares(v[i].dni) then
                contadorDigitosPares := contadorDigitosPares + 1;
            dobleMinimo(v, i, aluMayor1, aluMayor2);
        end;
    end;
// modulo leerAlumno
procedure leerAlumno(var alu: alumno);
    begin
        Write('Ingrese nro de inscripcion: ');
        ReadLn(alu.nroInscripcion);
        Write('Ingrese DNI: ');
        ReadLn(alu.dni);
        Write('Ingrese apellido: ');
        ReadLn(alu.apellido);
        Write('Ingrese nombre: ');
        ReadLn(alu.nombre);
        Write('Ingrese anio de nacimiento: ');
        ReadLn(alu.anioNacimiento);
    end;
// modulo cargarVectorAlumnos
procedure cargarVectorAlumnos(var v: vectorAlumnos);
    var
        i: integer;
    begin
        for i := 1 to dimF do
        begin
            WriteLn('Alumno ', i, ':');
            leerAlumno(v[i]);
        end;
    end;

var
    v: vectorAlumnos;
    contadorDigitosPares, aluMayor1, aluMayor2: integer;
    porcentaje: real;
begin
    contadorDigitosPares := 0;
    aluMayor1 := 1;
    aluMayor2 := 1;
    cargarVectorAlumnos(v);
    recorrerVectorAlumnos(v, contadorDigitosPares, aluMayor1, aluMayor2);
    porcentaje := (contadorDigitosPares * 100) / dimF;
    WriteLn('Porcentaje de alumnos con DNI compuesto solo por digitos pares: ', porcentaje:0:2, '%');
    WriteLn('Alumno de mayor edad: ', v[aluMayor1].apellido, ' ', v[aluMayor1].nombre);
    WriteLn('Alumno de segunda mayor edad: ', v[aluMayor2].apellido, ' ', v[aluMayor2].nombre);
end.