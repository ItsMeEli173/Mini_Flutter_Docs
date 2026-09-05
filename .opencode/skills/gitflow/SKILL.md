---
name: gitflow
description: "Trigger: rama, branch, gitflow, push, merge, PR, feature, release, bugfix, hotfix, dev, sqa, main. Apply the Fair-Play gitflow branch policy to the active repository."
license: Apache-2.0
metadata:
  author: "Elias"
  version: "1.0"
---

# Gitflow — Fair-Play

## Contrato de activación

Aplicar a toda creación de rama, push, merge, PR y operación de release en el repositorio activo. Verificar siempre el nombre de la rama, la rama destino y la autorización requerida antes de cualquier operación de Git.

## Reglas duras

- Ramas fijas: `main`, `sqa`, `dev`. Nunca eliminarlas ni renombrarlas.
- Ramas temporales: `feature`, `release`, `bugfix`, `hotfix`. Siempre eliminarlas después del merge.
- Nombres de rama cortos, SIEMPRE con prefijo de tipo + número: `feature/12-nombre-corto` (nunca `feature/cosas-varias-de-login-con-jwt-y-mas`).
- `main`: solo push con autorización explícita o instrucción específica del usuario. Nunca push directo.
- `sqa`: solo push cuando las pruebas automatizadas pasen.
- `dev`: push después de implementar cada cambio.
- Los merges siguen la ruta de promoción; nunca fusionar una rama temporal directamente en `main`.

## Puertas de decisión

| Situación | Crear rama | Fusionar en |
|---|---|---|
| Nueva funcionalidad | `feature/<num>-<slug>` | `dev` |
| Integración verificada por pruebas | `dev` | `sqa` |
| Candidato a release | `release/<num>-<slug>` | `sqa` y luego `main` |
| Defecto en funcionalidad existente | `bugfix/<num>-<slug>` | `dev` |
| Incidente de producción | `hotfix/<num>-<slug>` | `main` (con autorización) |

## Pasos de ejecución

1. Identificar el tipo de rama según la tabla de decisiones.
2. Crear la rama desde la base correcta: `feature`/`bugfix` desde `dev`; `hotfix`/`release` desde `main`.
3. Nombrarla con prefijo del tipo + número + slug corto (`feature/14-filtros-ausentismo`).
4. Hacer commits con conventional commits acotados a esa rama, con el mensaje en español.
5. Push según la puerta: tras implementar cada cambio → `dev`; tras pasar las pruebas → `sqa`; solo con autorización explícita → `main`.
6. Después del merge, eliminar la rama temporal.

## Contrato de salida

Devolver: el nombre exacto de la rama creada, su base, el destino del PR/merge y qué puerta autorizó el push (`dev` / `sqa` / `main` con autorización). Si falta la puerta, DETENERSE y reportar cuál falta; nunca hacer push.

## Referencias

- La política es autónoma: todas las reglas viven en esta skill; no depende de archivos externos. Si en el futuro agrego notas por repositorio, van en `references/`.