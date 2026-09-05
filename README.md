# Mini Flutter Docs

Una aplicación Flutter que te enseña **Flutter con Flutter**: cada concepto es una lección con su **ejemplo vivo e interactivo**, el nombre técnico, para qué sirve, cómo se usa y el código fuente.

> Construida como proyecto de aprendizaje personal para entender Flutter a nivel arquitectura: no cómo escribir sintaxis, sino **cómo tomar decisiones de diseño con fundamento**.

## ✨ Qué incluye

La app está organizada en **4 etapas de aprendizaje** para ir de lo básico a lo avanzado sin mezclar conceptos:

| Etapa | Tema | Lecciones |
|-------|------|-----------|
| 1 | Fundamentos | Widget, Stateless vs Stateful, Widget Tree |
| 2 | Layout & Styles | Row/Column, Container box model, SizedBox, Center/Spacer |
| 3 | State & Interaction | setState, TextField + controller, Navigator push/pop |
| 4 | Advanced Visual | AnimatedContainer, Glassmorphism, Transform 3D, CustomPainter, ShaderMask |

**Cada lección** muestra:
- Un **ejemplo vivo e interactivo** (tocás, deslizás, escribís)
- El **nombre técnico** del concepto
- **Para qué sirve** y **cómo se usa**
- Un **snippet de código** para copiar y estudiar

## 🚀 Cómo correrla

Requisitos: [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado y configurado.

1. Cloná el repositorio:
   ```bash
   git clone https://github.com/ItsMeEli173/Mini_Flutter_Docs.git
   cd Mini_Flutter_Docs
   ```
2. Instalá las dependencias:
   ```bash
   flutter pub get
   ```
3. Corré la app (Android, web o escritorio):
   ```bash
   flutter run
   ```

## 🧪 Tests

```bash
flutter test
```

## 🧭 Arquitectura del código

```
lib/
├── main.dart                → la app + el "escritorio" de etapas
├── lesson_card.dart         → tarjeta de lección compartida (DRY)
├── stage1_fundamentals.dart → Etapa 1: Fundamentos
├── stage2_layout.dart       → Etapa 2: Layout & Styles
├── stage3_state.dart        → Etapa 3: State & Interaction
└── stage4_visual.dart       → Etapa 4: Advanced Visual
```

Un detalle clave de diseño: `lesson_card.dart` reutiliza la misma tarjeta en todas las etapas (**principio DRY** — un solo lugar para el patrón visual compartido).

## 📄 Licencia

MIT — podés usarlo, modificarlo y compartirlo libremente. Mirá el archivo `LICENSE`.
