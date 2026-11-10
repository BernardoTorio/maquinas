# Máquinas Eléctricas · 2MB — I.E.S. Trinidad Arroyo (Palencia)

Web de clase para alumnos de FP de grado medio (16-17 años): apuntes y prácticas en PDF, animaciones HTML interactivas y tests. Se publica con **GitHub Pages** desde la rama `main`, carpeta raíz:
**https://bernardotorio.github.io/maquinas/** (repositorio `BernardoTorio/maquinas`, carpeta local `C:\dev\maquinas`).

Es de la misma familia que la web de Automatismos (`BernardoTorio/automatismos`): **las webs se mueven igual**, para que los alumnos no tengan que aprender tres maneras. Cuando haya que cambiar algo de aspecto o de navegación, primero se mira cómo está hecho allí (su `CLAUDE.md`, su `index.html` y su `test_diciembre.html`) y se copia y se adapta.

Los alumnos entran desde **códigos QR impresos en los apuntes**, que apuntan a `https://bernardotorio.github.io/maquinas/<archivo>.html`. Por eso:
- **Los nombres de archivo no se cambian nunca**: al corregir algo se sobrescribe el mismo archivo.
- **Las animaciones y los tests se quedan en la raíz** (no se mueven a subcarpetas).
- **Los nombres de las pestañas (`#temas`, `#practicas`, `#animaciones`, `#tests`) no se cambian**: las animaciones y los tests vuelven a ellas.

## Estructura del repositorio
```
index.html                 portada: «Ahora en clase», el curso tema a tema y las pestañas Apuntes, Prácticas, Animaciones y Tests
test_repaso.html           Test de iniciación 1 (40 preguntas)
test_repaso_2.html         Test de iniciación 2 (50 preguntas)
test_intermedio.html       Test intermedio (100 preguntas; las de la práctica, con la gráfica del ensayo de vacío)
test_intermedio_2.html     Test intermedio 2 (100 preguntas sobre lo que explican las animaciones)
*.html                     una animación por archivo (en la raíz)
temas/                     apuntes en PDF (T1_T3_Electromagnetismo_Transformadores_Maquinas.pdf, T5_Motores_electricos_Maquinas.pdf, T6_Variadores_Maquinas.pdf)
practicas/                 enunciados y hojas de las prácticas en PDF (P1_Maquinas.pdf, P1_Hoja_ensayos_Maquinas.pdf, P1_Resultados_4_trafos.pdf)
subir.bat                  publica todo con doble clic
.gitignore                 *.zip y *.docx (no se suben nunca)
```
- Apuntes y prácticas se suben **solo en PDF**. Para actualizar uno, se sustituye el PDF con el **mismo nombre**.
- Cada página es **un solo `.html` con todo dentro** (CSS y JS); de fuera solo Google Fonts (Atkinson Hyperlegible). Todas con modo claro y oscuro.

## index.html (portada)
- Mismo aspecto que la de Automatismos: fondo de papel, sin sombras, raíl rojo «L» arriba y azul «N» abajo, números con forma de borne.
- Arriba, el bloque **«Ahora en clase»**: apuntes, práctica y animaciones (en orden) del tema que se está dando. Al pasar de tema solo se cambia un número: **`var HOY = [1, 3];`**, al principio del primer `<script>`. Puede ser un tema (`var HOY = 5;`) o varios que se dan a la vez, entre corchetes (hoy, el 1 y el 3: comparten apuntes). Con varios, el bloque junta sus apuntes (una vez si el PDF es el mismo), sus prácticas y una fila de animaciones por tema. Debajo está la lista `T` de los temas (apuntes, práctica y otros accesos de cada uno).
- Después, una fila de pestañas: `#inicio` («Por temas», por defecto), `#temas` (se llama «Apuntes»), `#practicas`, `#animaciones` y `#tests`. Las secciones tienen id `sec-inicio`, `sec-temas`… para que el navegador no salte al abrir con `#…`.
- **«Por temas»**: los temas de `HOY` (marcados «ahora») y los anteriores, el último arriba; los que aún no se han dado salen debajo, en «Más adelante».
- **Temas sin enlazar**: `var SIN_ANIM = [5, 6];` (justo debajo de `HOY`) son los temas cuyas animaciones todavía no se enseñan: no salen en la pestaña Animaciones ni en «Por temas». Las páginas siguen en la raíz y se abren con su dirección, pero desde la web no hay acceso. Para volver a enseñarlas, se quita su número de la lista.
- **Animaciones**: un desplegable por tema (abiertos los de `HOY`). Las tarjetas salen de la lista `ANIM` (archivo, título, descripción y puntos de los apuntes): para añadir una animación, una línea ahí. El número de la tarjeta es su punto de los apuntes («3.15», «1.2 y 1.3», «1.3 a 1.5»).
- Prácticas y Apuntes: un recuadro por PDF con enlace `download`. Si el PDF todavía no está en el servidor, un `fetch HEAD` lo marca en gris como «próximamente» (también en «Ahora en clase» y en «Por temas»).
- **Marca «✓ vista»**: las animaciones que ya se han abierto en ese navegador salen marcadas. La pone la portada al tocar una tarjeta y cada animación al abrirse (también desde un QR). No se marca en los tests.
- En todas las páginas, la primera miga («Máquinas Eléctricas») lleva a `index.html`.

## Lo que se guarda en el navegador
`bernardotorio.github.io` es el mismo sitio para todas las webs (automatismos, maquinas, domotica…), así que aquí **todas las claves de `localStorage` empiezan por `maq-`**:
- `maq-tema`: modo claro u oscuro.
- `maq-visto:<archivo>`: animación ya abierta.
- `maq-testProg:<archivo>`: test a medias.

## Tests
Los cuatro llevan el mismo motor que los de Automatismos (`DATA`, `IMGS`, `show`, `paint`, `answer`, `result`).
- A la izquierda, el **mapa de preguntas** con colores (verde, rojo, gris) y, a la derecha, **«Cómo vas»**; por debajo de 1240 px de ancho (móvil y tablet), una barra abajo que abre el mapa.
- Se salta entre preguntas con anterior / siguiente, −10 / +10, el mapa, las flechas ← → y AvPág / RePág. Se puede terminar con preguntas sin contestar: no cuentan en la nota y después se pueden hacer «las que faltan».
- El **test a medias se guarda solo en ese navegador**: al volver, la pantalla de inicio ofrece «Seguir donde lo dejé» o «Borrarlo». Se borra al terminarlo entero.
- Al fallar, el mensaje dice «La buena es la opción C».
- **«Por orden»** coincide con el test en papel: mismo número de pregunta y mismas letras (el orden de las respuestas está en `q.o`). Si se cambia una pregunta, se cambia también su Word en papel.
- **Letras en los puntos de medida**: hoy no hacen falta. La única figura es la gráfica del ensayo de vacío de los 4 trafos (tests intermedios) y ninguna pregunta mide con el polímetro sobre un dibujo. Si algún día hay preguntas así, se hace como en Automatismos: una letra en bolita amarilla (A, B, C…, sin I, L, N ni O) en cada tornillo que se usa, `Ⓐ`, `Ⓑ`… en `DATA`, y el «¿Por qué?» empieza diciendo qué tornillo es.
- Vuelven a `index.html#tests` (botón, Esc y Retroceso).

## Animaciones
Las de los Temas 5 y 6 están hechas pero **sin enlazar desde la portada** (`SIN_ANIM`), hasta que se den esos temas.

| Grupo | Paso | Archivo | Qué muestra |
|---|---|---|---|
| Tema 1 | 1.2 | `imanes_lineas.html` | Un imán, dos que se atraen y dos que se repelen; líneas, limaduras y brújula |
| Tema 1 | 1.2 y 1.3 | `flujo_induccion.html` | Una ventana sobre el imán: flujo (total de líneas) e inducción (líneas por cuadradito) |
| Tema 1 | 1.3 a 1.5 | `circuito_magnetico.html` | Corriente, espiras, longitud, grosor, hierro o aire y entrehierro |
| Tema 1 | 1.6 | `campo_corriente.html` | Cable, espira y bobina; brújulas y regla de la mano derecha |
| Tema 1 | 1.7 | `fuerza_conductor.html` | Fuerza sobre un cable y una espira; regla de la mano izquierda |
| Tema 1 | 1.8 | `induccion.html` | Imán y bobina, electroimán con alterna o continua, espira que gira |
| Tema 1 | 1.9 | `curva_magnetizacion.html` | Zona recta, codo y saturación de cada material |
| Tema 1 | 1.10 | `histeresis.html` | Ciclo de histéresis, remanencia, materiales blandos y duros |
| Tema 1 | 1.11 | `foucault.html` | Núcleo macizo frente a núcleo de chapas |
| Tema 3 | 3.12 | `trafo_funcionamiento.html` | Primario, secundario y flujo; espiras; prueba con continua |
| Tema 3 | 3.13 | `homologos.html` | Dónde va el punto; cuatro bobinas de 50 V en serie |
| Tema 3 | 3.14 | `tipos_trafo.html` | El dibujo de cada tipo y modo examen |
| Tema 3 | 3.15 | `ensayo_vacio.html` | Ensayo de vacío: aula, trafo típico y trafo de 1 MW |
| Tema 3 | 3.16 | `ensayo_cortocircuito.html` | Ensayo de cortocircuito |
| Tema 3 | 3.17 | `ensayo_carga.html` | Ensayo de carga: caída de tensión y rendimiento |
| Tema 3 | 3.18 | `aislamiento.html` | Las tres medidas con el megóhmetro |
| Tema 5 | 5.4 | `campo_giratorio.html` | Campo giratorio, polos, frecuencia, carga e intercambio de fases |
| Tema 5 | 5.4.2 a 5.8 | `curva_par.html` | Curvas de par e intensidad, deslizamiento, térmico |
| Tema 5 | 5.6 | `placa_bornes.html` | Estrella o triángulo según la placa y la red |
| Tema 5 | 5.7 | `arranques.html` | Directo, estrella-triángulo, arrancador suave y variador |
| Tema 6 | 6.1 y 6.2 | `variador.html` | Partes del variador, marcha, rampas y curva V/f |
| Tema 6 | 6.3 | `cargas.html` | Par constante, cuadrático y potencia constante |
| Práctica 1 | Nuestros trafos | `problemas_trafos.html` | Qué les pasó a los 4 trafos, con los datos de sus hojas |
| Práctica 1 | Medir | `medir.html` | Calibre y micrómetro, con práctica al azar |
| Práctica 1 | Ajuste del hierro | `ajuste_hierro.html` | Cuántas chapas pide el paso 10 de cada trafo |
| Práctica 1 | Calculadora | `calculadora_trafo.html` | Calculadora de trafos con carrete de 40 × 40 mm |

### Reglas de las animaciones (todas)
- **Barra de arriba**: botón «← Índice», migas («Máquinas Eléctricas › Animaciones › Tema 3 › 3.15 Ensayo de vacío») y botón de modo claro/oscuro. En el móvil las migas se esconden.
- «← Índice», **Esc** y **Retroceso** vuelven a la pestaña donde está la animación: `index.html#animaciones` o, las de la Práctica 1, `index.html#practicas`. Retroceso no actúa con el foco en un campo o un desplegable.
- Bajo la barra, la **tira del tema** (`.tnav`): «‹ anterior · Tema 3 · 4 de 7 · siguiente ›» y todos los pasos del grupo, con un ✓ en los ya abiertos. En la Práctica 1 las flechas dicen «‹ Anterior» y «Siguiente ›». En la última, la flecha es «Fin ›» y vuelve al índice.
- Al final de la página, el botón grande **«Siguiente: 3.16 Ensayo de cortocircuito →»**; en la última, «Has llegado al final del Tema 3 · Volver a las animaciones →».
- Debajo de «Qué pasa» (el cajón que cambia en cada momento), un cajón fijo **«Para qué sirve»** de dos o tres frases, con lenguaje sencillo y sin fórmulas.
- Cada animación se marca como vista al abrirse (`maq-visto:<archivo>`).
- Las explicaciones van en cajones debajo del dibujo; nada de una columna lateral alta.

### Al añadir, quitar o reordenar una animación
1. `index.html`: una línea en `ANIM` (o en `HERR`, si es una herramienta de la práctica).
2. La tira hay que actualizarla **en todas las animaciones del grupo**. Se hace con el guion `tira_tema.py` (guardado en el proyecto «Materiales para instituto» de claude.ai, en `claude/herramientas/`): se añade la animación a `GRUPOS` y su texto a `PQS`, y se pasa con `python3 tira_tema.py <carpeta>`. Regenera la tira y el botón «Siguiente» de todas, y pone lo demás solo donde falte. La página nueva tiene que tener la barra de arriba (o el botón «← Índice» justo después de `<main>`) y un cajón con `id="exp"` dentro de un `<div class="boxes">`.
3. Añadir su fila a la tabla de arriba.

## Cómo se publica
1. Doble clic en `subir.bat`: descomprime el `maquinas*.zip` más reciente si lo hay (aquí o en Descargas), ordena los PDF en `temas/` y `practicas/`, hace `git add -A`, commit con fecha y `push`, y abre la web. Recargar con **Ctrl+F5** si se ve la versión vieja.
2. **Ojo:** `subir.bat` no hace `git pull`. Si se ha publicado algo desde otro sitio (por ejemplo, Claude desde la nube), hay que hacer antes `git pull` en `C:\dev\maquinas`, o el `push` será rechazado.
3. Si se trabaja con Claude en vez del .bat: un commit claro por bloque, a `main`, probado antes en escritorio y en móvil (400 px), en claro y en oscuro, y revisado después en la web publicada. **Nunca subir zips ni .docx.**
4. Esto es una web de clase: los cambios de forma se hacen sin más; si un cambio toca lo que se explica o el texto de una pregunta, se pregunta antes.
