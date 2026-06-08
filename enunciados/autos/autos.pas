{
  (
    Una agencia de motocicletas necesita un programa para administrar la información de las reservas de turnos para realizar los servicios de
    mantenimiento durante el mes de noviembre de 2025. Se dispone de una estructura con la información de las reservas de turnos. De cada reserva
    de turno se conoce: código de reserva, DNI del cliente, día en el cual deberá realizar el servicio (1..30), hora de inicio (7..19), hora de fin (7..19)
    y tipo de servicio (1..5). Además, se dispone de otra estructura con el precio por hora que deberá abonar el cliente de acuerdo al tipo de
    servicio.
    Se pide:
      a. Generar una nueva estructura con código de reserva y precio total de
      cada reserva. Esta estructura debe generarse ordenada de manera
      descendente por el código de reserva de turno. ✅
      b. Informar los dos días del mes con mayor cantidad de reservas de
      clientes con DNI que contenga al menos 3 dígitos impares.✅
      c. Realizar un módulo que reciba la estructura generada en a. y retorne el
      promedio de precio total que están pagando los clientes en noviembre de 2025.
  )

  Se dispone:
    turnos =
    - código: int.
    - DNI: in.
    - día: (1..30).
    - horaInicio: (7..19).
    - horaFin (7..19).
    - tipoServicio: (1..5).

    precios = [1..5] relacionada con "tipoServicio".

  A) responsabilidad "nueva estructura" (

    - Generar: (*2)
      nueva estructura = (*2)
        - código: int. (*2)
        - precio total: real. (*1)

    ordenada descendente (código) (*3)

    // calcular precio total (*1)
      con el numero de "tipo de servicio" puedo usarlo como indice para el array "precios".
      precioTotal = horaFin - horainicio * precio por hora.
    // crear un registro (*2)
    // insertar ordenado (*3)
      datos:
        - pri, nuevo, act, ant:lista
        - nro: int

      inicializar
        - crear nodo (sin siguiente)
        - act = pri
        - ant = pri

      condiciones:
        mientras (act <> nil) Y (nro < actual) hacer
          ant = act
          act = act-siguiente
        fin mientras

        si (act = ant) entonces
          pri = nuevo
        si no
          ant-siguiente = nuevo;

        nue-siguiente = act

  )
  B) responsabilidad "crear y encontrar 2 maximos" (

    - Informar
    - dos dias (*3)
    - mayor cantidad de reservas (*2)
      - clientes DNI dígitos impares >= 3 (*1)

    // analizar digitos del dni (funcion devuelve boolean)
    // contador de reservas (modifica el vector de maximos)
    // encontrar 2 maximas (recorre el vector) (fuera del recorrido de la lista)

  )
  C) responsabilidad "porcentaje" (

    - recorrer estructura de "a"
    - retorne promedio de precio total

  )

  aclaraciones:
    - reservas: vector 1..30 y los precios: lista.
    - manejar cuando no haya reservas o cuando los días con mayor cantidad de reservas sean iguales.
    - el promedio se calcula dividiendo la suma total de los precios entre la cantidad de reservas.
    - inicializar el vector de maximos con valores mínimos para asegurar que cualquier cantidad de reservas sea mayor.
    - las esctructuras a usar son:
      - lista.
      - registro:
        - código: int.
        - precio total: real.
      - vector para contar reservas por día (1..30).
      - los que menciona el enunciado (turnos y precios) ya se dispones, solo ejercutar "cargarLista".
}

program autos;
// Tipos
const
 dimFPrecios = 5;
 dimFDias = 30;
type
  precios = array [1..dimFPrecios] of real;
  dias = array [1..dimFDias] of integer;
  reserva = record
    codigo: integer;
    dni: integer;
    dia: 1..30;
    horaInicio: 7..19;
    horaFin: 7..19;
    tipoServicio: 1..5;
  end;
  nuevaEstructura = record
    codigo: integer;
    precioTotal: real;
  end;
  lista = ^nodo;
  nodo = record
    elem: reserva;
    sig: ^nodo;
  end;
  nuevaLista = ^nuevoNodo;
  nuevoNodo = record
    elem: nuevaEstructura;
    sig: ^nuevoNodo;
  end;

// Modulos
// accion A
function precioTotal(horaFin, horaInicio: integer; precio: real): real;
  var
  horas: integer;
  begin
    horas:=horaFin - horaInicio;
    precioTotal:=horas * precio;
  end;
procedure cargarRegistro(var r: nuevaEstructura; codigo: integer; precio:real);
  begin
    r.codigo:= codigo;
    r.precioTotal:= precio;
  end;
procedure insertarOrdenadoDescendente(pri: nuevaLista; dato: nuevaEstructura);
  var
    nuevo, act, ant: nuevaLista;
  begin
    new(nuevo);
    nuevo^.elem:=dato;

    act:=pri;
    ant:=pri;

    while(act <> nil) and (dato.codigo > act^.dato.codigo) do begin
      ant:=act;
      act:=act^.sig;
    end;

    if(act = ant) then pri := nuevo
    else ant^.sig := nuevo;

    nuevo^.sig := act;
  end;
// accion B
function digImpares(num: integer):boolean;
  var
    impar, dig: integer;
  begin
    dig:=0;
    impar:=0;

    while (num <> 0) and (impar < 3) do begin
      dig:=num MOD 10;

      if ((dig mod 2) <> 0) then impar:=impar + 1;

      num:= num DIV 10;
    end;

    digImpares:= (impar >= 3);
  end;
procedure inicializarVector (var v: dias);
  var i: integer;
  begin
    for i:=1 to dimFDias do v[i]:=0;
  end;
procedure cargarVector(var v:dias; dia: integer);
  begin
    v[dia] := v[dia] + 1;
  end;
procedure encontrar2Maximos (v: dias; var max1, max2: integer);
  var i: integer;
  begin
    max1:=1;
    max2:=1;
    for i:=2 to dimFDias do begin
      if(v[i] >= v[max1]) then begin
        max2:=max1;
        max1:=i;
      end
      else
        if (v[i] > v[max2]) then max2:=i;
    end;
  end;
// accion C
function promedioPreciosTotales (pri:nuevaLista):real;
  var
    cant: integer;
    total: real;
  begin
    cant:=0;
    total:=0;

    while pri <> nil do begin
      cant:=cant + 1;
      total:=total + pri^.elem;

      pri:=pri^.sig;
    end;

    promedioPreciosTotales := total / cant;
  end;
// generales
procedure recorrerLista (L: lista; var nuevL: nuevaLista);
  var
    max1, max2: integer;
    vDias: dias;
    precio, promedioPago: real;
    dato: nuevaEstructura;
  begin
    while (L <> nil) do begin
      precio:=precioTotal(l^.elem.horaInicio, L^.elem.horaFin, v[L^.elem.tipoServicio]);
      cargarRegistro(dato, L^.elem.codigo, precio);
      insertarOrdenadoDescendente(nuevL, dato);

      inicializarVector(vDias);
      if (digImpares(L^.elem.dni)) then cargarVector(vDias, L^.elem.dia);

      L:=L^.sig;
    end;

    encontrar2Maximos(vDias, max1, max2);

    writeln('Los dos dias del mes con mayor cantidad de reservas de clientes con DNI que contenga al menos 3 dígitos impares son: ', max1, ' y ', max2);

    promedioPago:=promedioPreciosTotales(nuevL);
    writeln('El promedio de precio total que están pagando los clientes en noviembre de 2025 es: ', promedioPago:0:2);
  end;

var
  L: lista;
  nuevaL: nuevaLista;
begin
  cargarLista(L);
  recorrerLista(L, nuevaL);
end.
{lPreciosTotales: nuevaLista;
  l: lista;}