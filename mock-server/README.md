# Proxy del asistente ExploraIA

Servidor local de la Sesión 9. **No forma parte de la app Flutter.** Es el único lugar donde vive la clave del proveedor de IA: la app solo conoce la dirección del proxy. (El nombre de la carpeta es histórico: antes el proxy solo respondía con reglas.)

Tiene dos modos, según exista o no la variable de entorno `GEMINI_API_KEY` al encenderlo:

| Modo | Cuándo | Qué hace |
|---|---|---|
| **GEMINI** | Con `GEMINI_API_KEY` definida | Llama al modelo de Google con tu clave gratuita |
| **REGLAS** | Sin clave | Responde con reglas simples, sin internet; sirve para seguir practicando si se agota la cuota del día |

## Obtener la clave gratuita

1. Entra a <https://aistudio.google.com/apikey> con una cuenta personal de Google (se exige mayoría de edad).
2. Pulsa **Create API key** y copia la clave.
3. **No la escribas en ningún archivo del proyecto ni la subas a git.** Se define solo en la terminal del proxy.

El plan gratuito permite pocas consultas al día (los límites exactos se ven en AI Studio) y Google puede usar el contenido de esas consultas para mejorar sus productos: por eso al proxy solo viaja el resumen por categoría.

## Cómo se usa

Linux y Mac:

```bash
cd mock-server
export GEMINI_API_KEY="pega-aquí-tu-clave"
node mock-server.js
```

Windows (PowerShell):

```powershell
cd mock-server
$env:GEMINI_API_KEY="pega-aquí-tu-clave"
node mock-server.js
```

Requiere Node.js 18 o superior. El mensaje inicial indica el modo (`modo GEMINI` o `modo REGLAS`). El modelo por defecto es `gemini-3.5-flash-lite`; se cambia con la variable `GEMINI_MODEL` (por ejemplo, si Google lo retira).

Para pasar al modo reglas, cierra el proxy (`Ctrl + C`), borra la variable y vuelve a encenderlo:

```bash
unset GEMINI_API_KEY
node mock-server.js
```

(En PowerShell: `Remove-Item Env:GEMINI_API_KEY`.)

## Contrato

`POST /asistente`, con la cabecera `Authorization: Bearer <token>` (el proxy no la lee ni la registra: en un proxy real se reenviaría al backend si hiciera falta actuar en nombre de la persona).

Petición:

```json
{ "consulta": "¿cuánto me queda en comida?",
  "resumen": { "categorias": [ { "categoria": "comida", "total": 20.0, "cantidad": 2, "disponible": 480.0 } ],
               "total_general": 20.0 } }
```

Respuesta (`accion` es opcional):

```json
{ "respuesta": "Te quedan 480.00 en comida (límite de 500 por categoría).",
  "accion": { "tipo": "registrar_gasto", "descripcion": "Almuerzo", "monto": 6.5, "categoria": "comida" } }
```

Errores (siempre `{ "detail": "mensaje legible" }`, que la app muestra tal cual):

| Código | Cuándo |
|---|---|
| 422 | Falta la consulta o pasa de 500 caracteres |
| 429 | Se agotó la cuota gratuita de la IA |
| 502 | La clave fue rechazada, la IA devolvió algo inesperado o no hay conexión a internet |
| 504 | La IA tardó más de 15 segundos |

En modo GEMINI el proxy valida la respuesta del modelo antes de enviarla: una acción incompleta, de otro tipo o con una categoría inexistente se descarta y solo llega el texto.

## Probar el proxy sin la app

Con el proxy encendido, desde la carpeta raíz del proyecto (en PowerShell usa `curl.exe` en vez de `curl`):

```bash
curl -X POST -H "Content-Type: application/json" -d @mock-server/ejemplo-consulta.json http://localhost:3000/asistente
curl -X POST -H "Content-Type: application/json" -d @mock-server/ejemplo-registro.json http://localhost:3000/asistente
```

## URL de la app

En el emulador Android la app usa por defecto `http://10.0.2.2:3000` (valor de `LLM_BACKEND_URL`); no hay que cambiar nada. El backend de gastos tiene su propia URL (`API_BASE_URL`, puerto 8000).

## Qué reconoce el modo reglas

| Escribes | Responde |
|---|---|
| ¿En qué categoría gasto más? | La categoría con mayor total del resumen |
| ¿Cuánto me queda en comida? | El campo `disponible` de esa categoría |
| Registra un almuerzo de 6.50 en comida | Propone una `accion` (la app pide confirmación antes de crear nada) |
| ¿Qué lugar barato de comida me recomiendas? | Una respuesta genérica |
| Cualquier otra cosa | «No entendí tu pregunta…» |

## Seguridad

- La clave solo se lee de la variable de entorno; el proxy nunca la imprime ni la guarda, y viaja en una cabecera (no en la URL) hacia Google.
- El registro del proxy muestra el tamaño y los **nombres** de los campos recibidos, nunca su contenido.
- Si una clave se filtra, se crea otra en AI Studio y se desactiva la anterior.
