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
temas/                     apuntes en PDF (T1_T3_Electromagnetismo_Transformadores_Maquinas.pdf, T4_Devanados_Maquinas.pdf, T5_Motores_electricos_Maquinas.pdf, T6_Variadores_Maquinas.pdf)
practicas/                 enunciados y hojas de las prácticas en PDF (P1_Maquinas.pdf, P1_Hoja_ensayos_Maquinas.pdf, P1_Resultados_4_trafos.pdf,
                           P2_Maquinas.pdf, P2_Plantilla_24_ranuras_Maquinas.pdf, P2_Plantilla_36_ranuras_Maquinas.pdf)
.github/, .lycheeignore    revisión de enlaces al subir (ver «Comprobaciones automáticas»)
subir.bat                  publica todo con doble clic
.gitignore                 *.zip y *.docx (no se suben nunca)
```
- Apuntes y prácticas se suben **solo en PDF**. Para actualizar uno, se sustituye el PDF con el **mismo nombre**.
- Cada página es **un solo `.html` con todo dentro** (CSS y JS); de fuera solo Google Fonts (Atkinson Hyperlegible). Todas con modo claro y oscuro.

## index.html (portada)
- Mismo aspecto que la de Automatismos: fondo de papel, sin sombras, raíl rojo «L» arriba y azul «N» abajo, números con forma de borne.
- Arriba, el bloque **«Ahora en clase»**: apuntes, práctica y animaciones (en orden) del tema que se está dando. Al pasar de tema solo se cambia un número: **`var HOY = 4;`**, al principio del primer `<script>`. Puede ser un tema (hoy, el 4) o varios que se dan a la vez, entre corchetes (`[1, 3]`, que comparten apuntes). Con varios, el bloque junta sus apuntes (una vez si el PDF es el mismo), sus prácticas y una fila de animaciones por tema. Debajo está la lista `T` de los temas (apuntes, práctica y otros accesos de cada uno).
- Después, una fila de pestañas: `#inicio` («Por temas», por defecto), `#temas` (se llama «Apuntes»), `#practicas`, `#animaciones` y `#tests`. Las secciones tienen id `sec-inicio`, `sec-temas`… para que el navegador no salte al abrir con `#…`.
- **«Por temas»**: arriba el de `HOY` (marcado «ahora»), después el siguiente (marcado «lo siguiente») y luego los anteriores, el último arriba (hoy: 4, 5, 3 y 1); los demás salen debajo, en «Más adelante». La pestaña **Prácticas** va en el mismo orden (hoy, la Práctica 2 arriba y la 1 debajo): cada práctica está en un `<div class="pblk" data-t="n">` con el número de su tema, y el guion las coloca solo.
- **Temas sin enlazar**: `var SIN_ANIM = [6];` (justo debajo de `HOY`) son los temas cuyas animaciones todavía no se enseñan: no salen en la pestaña Animaciones ni en «Por temas». Las páginas siguen en la raíz y se abren con su dirección, pero desde la web no hay acceso. Para volver a enseñarlas, se quita su número de la lista.
- **Animaciones**: un desplegable por tema (abiertos los de `HOY`). Las tarjetas salen de la lista `ANIM` (archivo, título, descripción y puntos de los apuntes): para añadir una animación, una línea ahí. El número de la tarjeta es **T y su punto de los apuntes** («T3.15», «T1.2 y 1.3», «T1.3 a 1.5»): lo pone `etq()`.
- **Prácticas**: debajo de los PDF y de «Qué les pasó a nuestros trafos», «Práctica 1 · animaciones del tema que te sirven» (lista `PRAC_T`: los cuatro ensayos del Tema 3, T3.15 a T3.18, que son los de la hoja de ensayos) y después las herramientas del taller (`HERR`). Como en Automatismos, las animaciones de un tema que se usan en una práctica salen también con ella; al añadir una, mirar si va en `PRAC_T`. Debajo, «Práctica 2 · Cálculo y construcción de un motor»: enunciado, las dos plantillas (24 y 36 ranuras) y, cuando el 4 no está en `SIN_ANIM`, «Práctica 2 · animaciones del tema que te sirven» (las 4 del Tema 4, `prt2`). **El solucionario de la Práctica 2 no se sube nunca** (está en el repositorio privado `provisional`).
- Prácticas y Apuntes: un recuadro por PDF con enlace `download`. Si el PDF todavía no está en el servidor, un `fetch HEAD` lo marca en gris como «próximamente» (también en «Ahora en clase» y en «Por temas»).
- **Marca «✓ vista»**: las animaciones que ya se han abierto en ese navegador salen marcadas. La pone la portada al tocar una tarjeta y cada animación al abrirse (también desde un QR). No se marca en los tests.
- En todas las páginas, la primera miga («Máquinas Eléctricas») lleva a `index.html`.
- **Letra delante del número (T, P, E)**, igual en las tres webs: cada animación dice a qué se refiere. **T** si explica un apartado del tema (`T3.15`, `T1.2 y 1.3`), **P** si es la solución de un ejercicio de una práctica (aquí, la Práctica 1: sus tarjetas, también las del taller, dicen `P1`; en la tira van con su nombre) y **E** si es un ejercicio suelto, como los de los exámenes (`E1`, `E2`). Va en las tarjetas, en «Ahora en clase» (`ruta` y `chips`), en la tira, en la última miga, en el título y en el botón «Siguiente». Los tests no llevan letra. Una animación nueva se pone ya con su letra.
  `tira_tema.py` ya lleva las etiquetas con T; las migas de las páginas que ya tienen barra no las toca: si cambia una etiqueta, se cambia su miga a mano.

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
Las de los Temas 4 y 5 ya se enseñan (las dos desde el 17/11/2026; las del 4, también en Prácticas con la Práctica 2; el Tema 5 tiene ya sus apuntes en `temas/`). Las del Tema 6 están hechas pero **sin enlazar desde la portada** (`SIN_ANIM`), hasta que se dé ese tema.

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
| Tema 4 | 4.4 a 4.17 | `dev_calculos.html` | Las cuentas paso a paso (Kpq, U, paso o amplitud, tabla de principios) y si se puede hacer; 12, 18, 30 y 48 ranuras |
| Tema 4 | 4.11 y 4.12 | `dev_imb1_bobinas.html` | Devanados imbricados de simple capa, de la tabla a la caja: grupos impares, el hueco, grupos pares, saltos, uniones, U1 y U2, flechas y polos, V y W |
| Tema 4 | 4.13 | `dev_imb2_bobinas.html` | Devanados imbricados de doble capa, de la tabla a la caja: paso entero, grupos pares en la misma ranura, uniones; V y W simplificadas o enteras |
| Tema 4 | 4.14 a 4.16 | `dev_conc_grupos.html` | Devanados concéntricos, de la tabla a la caja: bobina pequeña y amplitud, grupos, por polos o polos consecuentes |
| Tema 5 | 5.1 | `motor_generador.html` | Motor o generador: coche eléctrico (acelerar, soltar el pedal, bajar un puerto) y central de bombeo; reto ¿motor o generador? |
| Tema 5 | 5.3 | `partes_motor.html` | Las partes del motor: se desmonta en 4 pasos, jaula o rótor bobinado, corte de frente y reto de encontrar piezas |
| Tema 5 | 5.4 | `campo_giratorio.html` | Campo giratorio, polos, frecuencia, carga e intercambio de fases |
| Tema 5 | 5.4.2 a 5.8 | `curva_par.html` | Curvas de par e intensidad, deslizamiento, térmico |
| Tema 5 | 5.6 | `placa_bornes.html` | Estrella o triángulo según la placa y la red |
| Tema 5 | 5.7 | `arranques.html` | Directo, estrella-triángulo, arrancador suave y variador |
| Tema 5 | 5.9 | `averias_motor.html` | Un motor con una avería al azar (las 8 de la tabla del 5.9): se observa, se lee la placa y se mide con polímetro V~ y Ω, megóhmetro y pinza |
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

### Las del Tema 4 (devanados)
- Son **cuatro, una por cosa que hacer**: las cuentas y una por tipo de devanado (desde el 19/11/2026, lo pidió el profesor: antes eran siete y cada devanado se partía en «(1) las bobinas» y «(2) uniones y caja», y liaba). Cada una va seguida, de la tabla de principios a la caja de bornes. En la tira, debajo de cada número sale su nombre («Devanados imbricados de simple capa»…): grupo `t4` con `nombres=True` en `tira_tema.py`. Las antiguas «(2)» (`dev_imb1_uniones.html`, `dev_imb2_uniones.html`, `dev_conc_uniones.html`) siguen en la raíz, pero solo redirigen a la de su tipo en el primer paso de las uniones (`…#uniones`); no salen en la portada ni en la tira.
- Las cuatro salen de un mismo motor (cálculo y dibujo como los esquemas del tema), guardado en un solo archivo en el proyecto «Materiales para instituto»: `claude/maquinas/T4_animaciones.py` (el JavaScript va dentro, en `FUENTES`). Para cambiarlas se toca allí y se regeneran con `python3 T4_animaciones.py <carpeta>`; después, `python3 tira_tema.py <carpeta>`. No editar a mano los `dev_*.html`.
- **Ningún ejemplo es de la práctica** (24 y 36 ranuras): los hacen los alumnos. Las soluciones animadas de la práctica (D1 a D14 y las cuentas de los 18 casos) están en la web provisional (`BernardoTorio/provisional`, `m2_*.html`, sección `#m2`) y salen del mismo archivo con `--soluciones`: **nunca se copian aquí**. Ejemplos (desde el 24/11/2026, lo pidió el profesor): **12 y 48 ranuras con 2, 4, 6 y 8 polos en los tres tipos**, una fila de botones por número de ranuras. Los que no se pueden (12 con 6 y 8 polos; 12 con 4 polos en una capa; 48 con 6 polos, Kpq = 2,67) lo dicen en un solo paso «No se puede hacer», con el estator y las franjas de las fases (el dibujo de `dev_calculos.html`, que por eso va también dentro de las otras tres). En las cuentas, 12, 18, 30 y 48 ranuras.
- Orden de los pasos (24/11/2026, lo pidió el profesor; es la tabla de pasos del formulario): en los imbricados, primero los grupos impares (los de la tabla) y se cierran con sus saltos; después los pares (en una capa, desde la ranura siguiente a la que llega el primer haz; en doble capa, en esa misma) y se cierran; luego, «principio largo, final corto» y las uniones. En el concéntrico, primero los lados del grupo (U lados, m ranuras libres y otros U), sin cerrar; después se cierran las bobinas, luego los otros grupos y los saltos.
- Mismos criterios que los dibujos del tema: U rojo, V azul, W verde; cabezas arriba; saltos, uniones y cables abajo; doble capa continua arriba y discontinua abajo; cables a la caja siempre en vertical; flechas solo en U; S grises en los polos consecuentes.

### Las del Tema 5 nuevas (5.1, 5.3 y 5.9)
- Se editan directamente, como las otras del tema (cada `.html` lleva todo dentro; la cabecera de estilos es la de `campo_giratorio.html`). Si cambia la tira, se pasa `tira_tema.py`.
- `motor_generador.html` tiene dos dibujos: uno ancho y otro estrecho para el móvil (menos de 560 px).
- `averias_motor.html`: motor de 5,5 kW, Δ 400 V 11 A / Y 690 V 6,4 A, red de 400 V (va en triángulo), bobinas de 1,8 Ω, aislamiento bueno «> 999 MΩ» (como en `aislamiento.html`). Las 8 averías: falta una fase (fusible fundido), derivación a masa (salta el diferencial), sobrecarga, térmico mal regulado (ruleta a 8 A), espiras en cortocircuito (1,4 Ω), dos fases cambiadas, estrella en vez de triángulo y rodamientos gastados. Para medir en Ω o con el megóhmetro hay que quitar antes la tensión (consignar) y las chapas y los cables. Con la fase que falta y el contactor cerrado, ese borne marca unos 200 V con las otras (le llega por las bobinas); con el contactor abierto, 0 V.
- En el Word del tema, los tres llevan su recuadro «MÍRALO EN MARCHA» con QR (en el 5.1, el 5.3 y el 5.9).

### Al añadir, quitar o reordenar una animación
1. `index.html`: una línea en `ANIM` (o en `HERR`, si es una herramienta de la práctica).
2. La tira hay que actualizarla **en todas las animaciones del grupo**. Se hace con el guion `tira_tema.py` (guardado en el proyecto «Materiales para instituto» de claude.ai, en `claude/herramientas/`): se añade la animación a `GRUPOS` y su texto a `PQS`, y se pasa con `python3 tira_tema.py <carpeta>`. Regenera la tira y el botón «Siguiente» de todas, y pone lo demás solo donde falte. La página nueva tiene que tener la barra de arriba (o el botón «← Índice» justo después de `<main>`) y un cajón con `id="exp"` dentro de un `<div class="boxes">`.
3. Añadir su fila a la tabla de arriba.

## Comprobaciones automáticas (desde el 23/11/2026)
- **Antes de publicar**, Claude pasa `comprobar_web.py` (proyecto «Materiales para instituto», `claude/herramientas/`; skill «comprobar-web-de-clase»): abre todas las páginas con Chrome en escritorio y en móvil (400 px), en claro y en oscuro, y da **errores** (fallos de JavaScript, enlaces rotos —también los que la portada crea con JavaScript—, páginas que se salen por la derecha, la tira mal, un archivo que estaba y ya no está) y **avisos** (falta el botón de volver, la miga, el modo claro/oscuro o Esc). Con `--antes-git origin/main` dice además **qué páginas se ven distintas** que las publicadas: tienen que ser solo las que se han tocado.
- **Al subir** (`.github/workflows/enlaces.yml`), GitHub revisa con lychee los enlaces de los `.html` de la raíz. Si alguno apunta a un archivo que no existe, el commit sale con una ✗ roja en GitHub y llega un correo; la web se publica igual. Un PDF enlazado que todavía no está subido («próximamente») se apunta en `.lycheeignore` (una línea) y se quita al subirlo.
- **Cada noche**, el repositorio privado `BernardoTorio/comprobaciones` repite la comprobación completa de las tres webs y abre allí una incidencia si hay errores o páginas que han cambiado de aspecto desde la noche anterior.

## Los Word originales: `C:\dev\originales`
Los PDF de esta web salen de un Word. Los Word no se suben a GitHub, pero **no se pierden**: están en `C:\dev\originales` (en el PC del profesor, fuera de git), con todas sus versiones. Es la misma carpeta para las tres webs (automatismos, domotica, maquinas).
```
C:\dev\originales\
  automatismos\  domotica\  maquinas\
    temas\  practicas\  ejercicios\  tests\  examenes\  programacion\  otros\
      T1_T3_Electromagnetismo_Transformadores_Maquinas.docx                       ← la última versión
      versiones\T1_T3_Electromagnetismo_Transformadores_Maquinas__2026-09-22_2321.docx      ← todas, con fecha y hora
  _sin_clasificar\   _registro\ (índice, log, pdf_sin_word.txt)   reglas.csv   LEEME.txt
```
- **El Word se llama igual que el PDF que se publica** (`temas\T1_T3_Electromagnetismo_Transformadores_Maquinas.docx` → `temas/T1_T3_Electromagnetismo_Transformadores_Maquinas.pdf`) y lleva la asignatura en el nombre (`…_Automatismos`, `2MT-…`, `…_Maquinas_2MB`), para que se coloque solo.
- **Para cambiar un PDF publicado se parte de su Word de `C:\dev\originales`** (la última versión o, si hace falta, una de `versiones\`). Nunca se rehace un Word a partir del PDF sin mirar antes ahí; si no está (lo dice `_registro\pdf_sin_word.txt`), se avisa al profesor antes de reconstruirlo.
- **Todo Word nuevo o cambiado se guarda en su sitio de `C:\dev\originales`** en cuanto está hecho. Antes de escribir encima de la última versión, si en `versiones\` no está ya `nombre__AAAA-MM-DD_HHMM.docx` con la fecha de esa última, se copia allí con ese nombre. Si la sesión no tiene la carpeta, se pide acceso; si no se puede, el Word se deja en esta carpeta o en «Claude outputs» y la tarea de la noche lo recoge. Si un Word se llama distinto que su PDF, se añade su línea en `C:\dev\originales\reglas.csv`.
- Una tarea de Windows («Archivo de Word de clase», cada día a las 23:00 o al encender) guarda en `versiones\` los Word nuevos o cambiados de las tres webs (también «Claude outputs»), de Descargas y del propio archivo, y pone arriba la última. No mueve ni borra nada. Para que pase ya: `C:\dev\originales\archivar_ahora.bat`.

## Cómo se publica
1. Doble clic en `subir.bat`: descomprime el `maquinas*.zip` más reciente si lo hay (aquí o en Descargas), ordena los PDF en `temas/` y `practicas/`, hace `git add -A`, commit con fecha y `push`, y abre la web. Recargar con **Ctrl+F5** si se ve la versión vieja.
2. **Ojo:** `subir.bat` no hace `git pull`. Si se ha publicado algo desde otro sitio (por ejemplo, Claude desde la nube), hay que hacer antes `git pull` en `C:\dev\maquinas`, o el `push` será rechazado.
3. Si se trabaja con Claude en vez del .bat: un commit claro por bloque, a `main`, probado antes en escritorio y en móvil (400 px), en claro y en oscuro, y revisado después en la web publicada. **Nunca subir zips ni .docx.**
4. Esto es una web de clase: los cambios de forma se hacen sin más; si un cambio toca lo que se explica o el texto de una pregunta, se pregunta antes.
