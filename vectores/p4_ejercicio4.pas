{
    4. Se dispone de un vector con 100 números enteros. Implementar los siguientes módulos:
        a. posicion: dado un número X y el vector de números, retorna la posición del número X en dicho
        vector, o el valor -1 en caso de no encontrarse.

        b. intercambio: recibe dos valores x e y (entre 1 y 100) y el vector de números, y retorna el mismo
        vector donde se intercambiaron los valores de las posiciones x e y.
        c. sumaVector: retorna la suma de todos los elementos del vector.
        d. promedio: devuelve el valor promedio de los elementos del vector.
        e. elementoMaximo: retorna la posición del mayor elemento del vector
        f. elementoMinimo: retorna la posicion del menor elemento del vector
}

program p4_ejercicio4;
const dimF = 100;
type
    vector = array [1..dimF] of integer;
// Módulo a: posición
// function posicion(x: integer; v: vector): integer; "continuar aquí..."