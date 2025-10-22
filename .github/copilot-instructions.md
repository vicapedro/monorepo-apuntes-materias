# GitHub Copilot Instructions

## Repository Architecture
[Subject]/
├── [Subject].txt/.md             # Official program reference (USE THIS)
├── Diseño_Instruccional.md       # Course design (required)
├── [#. Unit]/                    # Sequential units
│   ├── *.md                      # Theory content
│   ├── *.xml                     # Moodle XML assessments
│   ├── A*.md                     # Activity assessments
│   ├── Actividad*.md             # Teaching activities
│   ├── Practica*.md              # Lab exercises
│   └── Portafolio.md             # Evidence portfolio


## Official Program Reference

**ALWAYS consult the official program file `[Subject].txt` or `[Subject].md` in each subject directory** for:

- 📋 **Official competencies to develop** - Use exact competencies from TecNM program
- 🎯 **Required prerequisite competencies** - Ensure proper curricular articulation  
- 📚 **Suggested bibliography** - Include recommended and complementary sources
- 🎓 **Suggested learning activities** - Align with official pedagogical approach
- ⏱️ **SATCA hours distribution** - Theory, practice, and autonomous work hours
- 🔗 **Curricular articulation** - How the subject connects with others in the curriculum

When creating any educational content, instructional design, or assessment instrument, reference this official program to ensure:
- ✅ **Competency alignment** with TecNM standards
- ✅ **Proper prerequisite validation** 
- ✅ **Bibliographic consistency** with institutional requirements
- ✅ **Activity alignment** with official learning objectives

## Assessment and its instruments
Assessment and its instruments in an educational context based on the development of competencies in students. Offer initial prototypes of different types of evidence along with their instruments supported by the impact indicators.
Each evidence has different impact indicators distributed across activities according to  "correspondencia_evidencia_indicadores.md"

## Critical Patterns

### Practice File Structure (ALWAYS follow exactly):
```
# Práctica X: [Title]
## Objetivo
**Duración estimada:** X horas
## Competencias a desarrollar
- Competency 1
- Competency 2
## Introducción
## Equipo de protección e higiene
## Material y equipo necesario
### Materiales e insumos
### Equipo de laboratorio
### Herramientas  
## Instrucciones
## Notas
```

### Moodle XML Assessment Format:
**Use Moodle XML format for automatically gradable question types and enhanced LMS compatibility:**

#### **Multiple Choice (Single Answer)**
```xml
<question type="multichoice">
    <name><text>Pregunta MC001</text></name>
    <questiontext format="html">
        <text><![CDATA[<p>¿Cuál es el comando principal para administrar servicios en systemd?</p>]]></text>
    </questiontext>
    <generalfeedback format="html">
        <text><![CDATA[<p>systemctl es la herramienta principal para controlar systemd y servicios.</p>]]></text>
    </generalfeedback>
    <defaultgrade>1.0000000</defaultgrade>
    <penalty>0.3333333</penalty>
    <hidden>0</hidden>
    <single>true</single>
    <shuffleanswers>true</shuffleanswers>
    <answernumbering>abc</answernumbering>
    <answer fraction="100" format="html">
        <text><![CDATA[systemctl]]></text>
        <feedback format="html"><text><![CDATA[¡Correcto! systemctl es el comando principal de systemd.]]></text></feedback>
    </answer>
    <answer fraction="0" format="html">
        <text><![CDATA[service]]></text>
        <feedback format="html"><text><![CDATA[Incorrecto. service es para SysV init, no systemd.]]></text></feedback>
    </answer>
</question>
```

#### **True/False**
```xml
<question type="truefalse">
    <name><text>Pregunta TF001</text></name>
    <questiontext format="html">
        <text><![CDATA[<p>El comando 'sudo apt update' actualiza los paquetes instalados a sus versiones más recientes en sistemas Debian/Ubuntu.</p>]]></text>
    </questiontext>
    <generalfeedback format="html">
        <text><![CDATA[<p>'apt update' solo actualiza la lista de paquetes disponibles. Para actualizar los paquetes instalados se usa 'apt upgrade'.</p>]]></text>
    </generalfeedback>
    <defaultgrade>1.0000000</defaultgrade>
    <penalty>1.0000000</penalty>
    <hidden>0</hidden>
    <answer fraction="0" format="html">
        <text>true</text>
        <feedback format="html"><text><![CDATA[Incorrecto. 'apt update' solo actualiza la lista de paquetes disponibles, no los paquetes instalados.]]></text></feedback>
    </answer>
    <answer fraction="100" format="html">
        <text>false</text>
        <feedback format="html"><text><![CDATA[¡Correcto! 'apt update' actualiza la lista de paquetes. Para actualizar paquetes instalados se usa 'apt upgrade'.]]></text></feedback>
    </answer>
</question>
```

#### **Multiple Choice (Multiple Answers)**
```xml
<question type="multichoice">
    <name><text>Pregunta MCA001</text></name>
    <questiontext format="html">
        <text><![CDATA[<p>¿Cuáles de los siguientes comandos pueden utilizarse para ver procesos en ejecución en Linux? (Seleccione todas las opciones correctas)</p>]]></text>
    </questiontext>
    <generalfeedback format="html">
        <text><![CDATA[<p>Existen múltiples herramientas para monitorear procesos: ps (estático), top/htop (dinámico), pgrep (por nombre).</p>]]></text>
    </generalfeedback>
    <defaultgrade>1.0000000</defaultgrade>
    <penalty>0.3333333</penalty>
    <hidden>0</hidden>
    <single>false</single>
    <shuffleanswers>true</shuffleanswers>
    <answernumbering>abc</answernumbering>
    <answer fraction="33.33333" format="html">
        <text><![CDATA[ps aux]]></text>
        <feedback format="html"><text><![CDATA[Correcto! ps aux muestra todos los procesos detalladamente.]]></text></feedback>
    </answer>
    <answer fraction="33.33333" format="html">
        <text><![CDATA[top]]></text>
        <feedback format="html"><text><![CDATA[Correcto! top muestra procesos en tiempo real.]]></text></feedback>
    </answer>
    <answer fraction="33.33333" format="html">
        <text><![CDATA[htop]]></text>
        <feedback format="html"><text><![CDATA[Correcto! htop es una versión mejorada de top.]]></text></feedback>
    </answer>
    <answer fraction="-100" format="html">
        <text><![CDATA[ls -la]]></text>
        <feedback format="html"><text><![CDATA[Incorrecto. ls lista archivos, no procesos.]]></text></feedback>
    </answer>
</question>
```

#### **Drag and Drop (Matching)**
```xml
<question type="ddwtos">
    <name><text>Pregunta DD001</text></name>
    <questiontext format="html">
        <text><![CDATA[<p>Arrastre los comandos a sus funciones correspondientes:</p>
        <p>[[1]] - Cambiar permisos de archivo</p>
        <p>[[2]] - Cambiar propietario de archivo</p>
        <p>[[3]] - Crear directorio</p>]]></text>
    </questiontext>
    <generalfeedback format="html">
        <text><![CDATA[<p>Comandos básicos de gestión de archivos en Linux.</p>]]></text>
    </generalfeedback>
    <defaultgrade>1.0000000</defaultgrade>
    <penalty>0.3333333</penalty>
    <hidden>0</hidden>
    <dragbox><text>chmod</text><group>1</group></dragbox>
    <dragbox><text>chown</text><group>1</group></dragbox>
    <dragbox><text>mkdir</text><group>1</group></dragbox>
    <dragbox><text>rmdir</text><group>1</group></dragbox>
</question>
```

#### **Advanced Question Types (Use only when specifically requested):**

**Cloze (Fill in the Blanks)** - Include only if user specifically requests cloze questions
**CodeRunner (Programming)** - Include only if user specifically requests programming/scripting evaluation

### Instructional Design Template:
- **Competencia General**: Course-level competency
- **Objetivos Específicos**: Unit learning objectives
- **Evidencias**: Matrix with activities, evidence, weighting (must = 100%), impact indicators A-F
- **Assessment**: 4-level rubrics (Excelente=3, Bueno=2, Aceptable=1, Insuficiente=0)

**CRITICAL: Activities in instructional design should be described at HIGH-LEVEL ONLY. Do not include detailed instructions, step-by-step processes, or specific procedures. These details belong in separate activity files (Actividad*.md or Practica*.md).**


### Evidence Matrix Structure Template:
```
| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Práctica de Laboratorio | Reporte técnico con capturas | 40% | 15% | 10% | 5% | 5% | 3% | 2% | Rúbrica |
| Proyecto Final | Sistema implementado + documentación | 35% | 10% | 8% | 7% | 5% | 3% | 2% | Lista de cotejo |
| Examen Teórico-Práctico | Resolución de casos | 25% | 8% | 7% | 5% | 3% | 1% | 1% | Rúbrica |
| **TOTAL** |  | **100%** | **33%** | **25%** | **17%** | **13%** | **7%** | **5%** |  |
```
**Each Unit has its own evidence matrix, with activities and evidence specific to that unit. The total ponderación must equal 100% per unit.**

**Impact Indicators (distribute only those that apply to each evidence type):**
- **A**: Adapts to complex situations and contexts
- **B**: Makes contributions to academic activities developed  
- **C**: Proposes solutions/procedures not seen in class
- **D**: Introduces resources promoting critical thinking
- **E**: Incorporates interdisciplinary knowledge
- **F**: Performs autonomous and self-regulated work

## Essential Workflows

### Modularizing Practices:
When splitting `Practicas.md` → create individual `Practica-##-Topic.md` + `Practicas-Indice.md` navigation


### Evidence Systems:
- Portfolio in PDF format with screenshots + reflection
- All practices require visual evidence and command outputs when needed

### Assessment Instruments:
**Rubric Template (4-level scale):**
```
| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|----------|---------------|-----------|---------------|------------------|
| Organización | Estructura clara y lógica | Estructura adecuada | Estructura básica | Sin estructura |
| Contenido técnico | Dominio completo | Dominio satisfactorio | Dominio básico | Sin dominio |
| Evidencias visuales | Capturas completas y relevantes | Capturas adecuadas | Capturas básicas | Sin capturas |
| Reflexión | Análisis profundo del aprendizaje | Reflexión adecuada | Reflexión básica | Sin reflexión |
```

**Lista de Cotejo Template:**
- [ ] Cumple con todos los objetivos planteados
- [ ] Incluye evidencias visuales (capturas de pantalla)
- [ ] Demuestra competencias técnicas específicas
- [ ] Presenta resultados de forma clara
- [ ] Incluye reflexión sobre el aprendizaje

## Integration Points

- **LMS**: Moodle integration for activities  
- **Assessment**: Moodle XML format for comprehensive question variety and LMS compatibility
- **Simulators**: Packet Tracer (networking), VirtualBox (systems)
- **Languages**: Spanish content, technical English terminology

## Instrumentación Didáctica TecNM

### Template Structure for Didactic Instrumentation:

**CRITICAL: When generating Instrumentación Didáctica, ALWAYS ensure complete coherence between:**
1. **Official Program** (`[Subject].txt/.md`) - Extract competencies, topics, bibliography exactly
2. **Instructional Design** (`Diseño_Instruccional.md`) - Align methodologies, evidence matrix, assessments
3. **Impact Indicators** - Distribute A-F according to evidence types and competency requirements

### Required Document Structure:

```markdown
# [Institution Name]
## Instrumentación Didáctica para la Formación y Desarrollo de Competencias

### 📋 Información General de la Asignatura
| Campo | Información |
|-------|-------------|
| **Nombre de la asignatura** | [From Official Program] |
| **Carrera** | [From Official Program] |
| **Clave de la asignatura** | [From Official Program] |
| **Horas teoría - Horas prácticas - Créditos** | [From Official Program] |

## 🎯 Caracterización de la asignatura
**[Extract EXACT general competency from Official Program]**

## 💡 Intención didáctica
[Extract and adapt from Official Program - professional context, curricular justification]

## 📚 Indicadores de Alcance por Competencia
[Use standard TecNM indicators A-F with full descriptions]

## 📊 Análisis por competencias específicas
[Use standard TecNM performance levels: Excelente, Notable, Bueno, Suficiente, Insuficiente]

## Unidad [X]: [Unit Name from Official Program]
### 🎯 Competencia
**[Code]** [Extract specific competency from Official Program]

### 📋 Temas y Subtemas
[Extract exactly from Official Program]

### 👨‍🎓 Actividades de aprendizaje
[Extract exactly from Official Program]

### 👨‍🏫 Actividades de enseñanza
[Coherent with selected pedagogical approach]

### 📊 Evidencias de aprendizaje
[Use HTML table format with proper indicator distribution]

<table>
<thead>
<tr><th>Criterio</th><th>Ponderación</th><th>Estrategia de evaluación</th><th colspan="6">Indicadores de Alcance</th></tr>
<tr><th></th><th></th><th></th><th>A</th><th>B</th><th>C</th><th>D</th><th>E</th><th>F</th></tr>
</thead>
<tbody>
<tr><td><strong>[EVIDENCE]</strong></td><td>[%]</td><td>[INSTRUMENT]</td><td>[X]</td><td>[X]</td><td>[X]</td><td>[X]</td><td>[X]</td><td>[X]</td></tr>
</tbody>
</table>

### 📚 Fuentes de Información
[Extract from Official Program and complement as needed]
```

### Critical Validation Requirements:

1. **Competency Coherence**: Unit competencies must match Official Program exactly
2. **Topic Alignment**: Themes and subtopics from Official Program verbatim  
3. **Bibliography Consistency**: Primary sources from Official Program + complementary
4. **Evidence Distribution**: Ponderations sum 100% per unit, indicators distributed per evidence type
5. **Methodology Integration**: Activities reflect selected active learning approach from Instructional Design
6. **Assessment Alignment**: Instruments match evidence types and evaluation criteria

### Quality Assurance Checklist:
- [ ] Official Program consulted and referenced
- [ ] Instructional Design methodology applied
- [ ] Evidence matrix totals 100% per unit
- [ ] Impact indicators A-F properly distributed
- [ ] Assessment instruments align with evidence types
- [ ] Activities promote active learning methodologies
- [ ] Bibliography includes official and complementary sources

## Assessment and Evaluation Framework

For assessment instruments, encourage the use of rubrics, supporting teachers in defining criteria and assessment levels. You can also use a checklist and observation guide.

**Use the comprehensive evaluation knowledge from `/shared/Evaluacion_Enfoque_Competencias.md` and `/shared/correspondencia_evidencia_indicadores.md` to:**

### Evidence-Based Assessment Recommendations:
- **Evidence by Knowledge**: Suggest appropriate instruments (open questionnaires, multiple choice, case analysis) based on cognitive complexity
  - **Indicators to use**: Only A (plus B, D for case analysis)
- **Evidence by Product**: Recommend rubrics or checklists for tangible outputs (essays, reports, projects, models)
  - **Indicators to use**: All indicators A, B, C, D, E, F
- **Evidence by Performance**: Propose observation guides for demonstrations, presentations, simulations
  - **Indicators to use**: All indicators A, B, C, D, E, F
- **Evidence by Attitude**: Design instruments for teamwork, responsibility, critical thinking behaviors
  - **Indicators to use**: All indicators A, B, C, D, E, F

### Competency-Assessment Alignment:
- Match **impact indicators A-F** to specific assessment instruments **according to official TecNM correspondence**
- Suggest **Gagné-aligned evaluation** using the hexagon model (What, Why, How, With What, When, Who)
- Recommend **diagnostic, formative, and summative** evaluation strategies based on learning phase
- Propose **authentic assessment** scenarios that mirror real-world professional contexts

### Assessment Design Using Hexagon Model:
**ALWAYS design evaluation strategies addressing the 6 hexagon dimensions:**

1. **¿QUÉ EVALUAR?** (What to assess?) - Content and competencies
   - Specific competencies from official TecNM program
   - Knowledge, skills, and attitudes to be evaluated
   - Learning outcomes and performance indicators
   - Alignment with impact indicators A-F

2. **¿POR QUÉ EVALUAR?** (Why assess?) - Purpose and justification
   - Diagnostic: Identify prior knowledge and learning needs
   - Formative: Monitor progress and provide feedback
   - Summative: Certify competency achievement
   - Professional relevance and workplace application

3. **¿CÓMO EVALUAR?** (How to assess?) - Methods and strategies
   - Select appropriate instruments (rubrics, checklists, observation guides)
   - Choose evidence types (knowledge, product, performance, attitude)
   - Apply active assessment methodologies aligned with learning approach
   - Ensure authentic and contextualized evaluation scenarios
   - **Align exam questions with Bloom's Taxonomy** cognitive levels for progressive complexity

4. **¿CON QUÉ EVALUAR?** (With what to assess?) - Tools and resources
   - Assessment instruments and criteria
   - Technological tools and platforms (Moodle quizzes, digital portfolios)
   - Physical resources and laboratory equipment
   - Reference materials and evaluation standards

5. **¿CUÁNDO EVALUAR?** (When to assess?) - Timing and sequence
   - Diagnostic assessment before instruction begins
   - Formative checkpoints throughout learning process
   - Summative evaluation at unit/course completion
   - Continuous assessment integrated with learning activities

6. **¿QUIÉN EVALÚA?** (Who assesses?) - Evaluators and participants
   - Teacher/instructor assessment and criteria
   - Student self-assessment and reflection
   - Peer evaluation and collaborative assessment
   - External/industry expert evaluation when applicable

**Document all assessment designs using these 6 dimensions for comprehensive evaluation planning.**


### Assessment Instrument Selection Guide:
- **Small populations**: Open questionnaires, case analysis, interviews
- **Large populations**: Multiple choice, checklists, standardized rubrics  
- **Complex competencies**: Portfolio, comprehensive projects, performance demonstrations
- **Technical skills**: Laboratory practices with observation guides and practical rubrics

### Bloom's Taxonomy Integration for Exam Design:
**When designing exams and assessment questions, ALWAYS align with Bloom's Taxonomy cognitive levels** to ensure progressive complexity and comprehensive competency evaluation:

#### **Level 1-2: Lower-Order Thinking Skills (Foundation)**
- **Recordar (Remember)**: Define, list, identify, label, name
  - Example: "Defina qué es un sistema operativo"
- **Comprender (Understand)**: Explain, describe, summarize, classify, compare
  - Example: "Explique las diferencias entre Windows Server y Linux"

#### **Level 3-4: Middle-Order Thinking Skills (Application)**
- **Aplicar (Apply)**: Use, demonstrate, execute, implement, solve
  - Example: "Configure un servidor DHCP en Windows Server siguiendo los pasos dados"
- **Analizar (Analyze)**: Examine, differentiate, organize, relate, compare structures
  - Example: "Analice los logs del sistema y determine la causa del error de red"

#### **Level 5-6: Higher-Order Thinking Skills (Advanced)**
- **Evaluar (Evaluate)**: Judge, critique, assess, defend, support, validate
  - Example: "Evalúe qué distribución de Linux es más apropiada para un servidor web empresarial"
- **Crear (Create)**: Design, construct, develop, formulate, plan, produce
  - Example: "Diseñe un plan de migración completo de Windows Server a Linux"

#### **Question Distribution Guidelines:**
- **20-30%** Recordar/Comprender (foundational knowledge verification)
- **40-50%** Aplicar/Analizar (practical application and problem-solving)
- **20-30%** Evaluar/Crear (critical thinking and innovation)

#### **Progressive Complexity Structure:**
1. **Start with foundational questions** to build confidence
2. **Progress to application scenarios** that mirror workplace tasks  
3. **Conclude with evaluation/creation** questions that demonstrate mastery
4. **Ensure authentic contexts** relevant to professional practice
5. **Include scaffolded questions** that build upon previous responses

**Example Exam Structure for Technical Subjects:**
```
Sección A: Conocimientos Fundamentales (25 pts - Recordar/Comprender)
- 5 preguntas de opción múltiple sobre conceptos básicos
- 2 preguntas de definición y explicación breve

Sección B: Aplicación Práctica (40 pts - Aplicar/Analizar) 
- 3 casos prácticos con análisis de comandos y configuraciones
- 2 ejercicios de resolución de problemas paso a paso

Sección C: Evaluación y Diseño (35 pts - Evaluar/Crear)
- 1 proyecto de evaluación de alternativas técnicas
- 1 ejercicio de diseño de solución integral
```

## Pedagogical Methodology Framework

**PRIORITIZE Active Learning Methodologies** in the following order of preference:

### Primary Active Methodologies (Highest Priority):
1. **🎯 Aprendizaje Basado en Problemas (ABP)**: Real-world problem solving that integrates knowledge, skills, and competencies
2. **🚀 Aprendizaje Orientado a Proyectos (AOP)**: Comprehensive projects that demonstrate practical application of learning
3. **⚡ Aprendizaje Basado en Retos (ABR)**: Challenge-based learning that promotes innovation and critical thinking
4. **📊 Estudio de Casos**: Analysis of authentic scenarios that develop decision-making and analytical skills
5. **🔄 Aula Invertida (Flipped Classroom)**: Students engage with content before class, apply knowledge during class

### Secondary Supporting Methodologies:
6. **🤝 Aprendizaje Cooperativo**: Structured collaborative learning with defined roles and accountability
7. **💬 Foros de Discusión**: Structured debates and discussions that promote critical thinking
8. **🎭 Demostraciones**: Practical demonstrations of skills, procedures, and techniques

### Traditional Methods (Use Minimally):
9. **📚 Clase Expositiva Tradicional**: Use only for foundational concepts introduction, limit to 20-30% of total instruction time

### Implementation Guidelines:
- **Combine methodologies** strategically within single learning experiences
- **Align methodology selection** with competency development objectives
- **Ensure authentic contexts** that mirror professional practice
- **Integrate technology tools** that enhance active engagement
- **Design assessments** that match the methodology used

Support teachers step-by-step through instructional design development using the Gagné Model, including: methodology selection, formative/summative assessment definition, evidence matrix creation (activity, evidence, weighting, indicators, instruments), and assessment instrument development.

Design learning experiences integrating active methodologies, collaborative projects, and digital tools to build student knowledge while fostering socio-emotional skills like leadership, teamwork, and critical thinking.

## Step-by-Step Instructional Design Workflow

**When developing instructional design, ALWAYS follow this comprehensive workflow:**

### Context Information Required:
- **Teacher's name** and preferred form of address
- **Subject/course** being worked on
- **Unit, topic, or competency** to be developed
- **Educational context**: Face-to-face classes, Moodle as LMS, Teams for communication
- **Course duration**: Standard academic period of 16 weeks, sessions typically 1 hour (60 minutes), 4-6 sessions per week, according to Satca hours
- **Session duration**: 1 hour (60 minutes)

### Instructional Design Process (Gagné Model-Based):

#### 1. **Methodology Selection Phase**
- Establish the **active learning strategy** for the topic, unit, or competency
- Follow the **Priority Order**: ABP → AOP → ABR → Case Studies → Flipped Classroom (as defined in Pedagogical Framework)
- Consider **ethical AI integration** by students in appropriate activities
- Design activities for **both teacher and student** roles

#### 2. **Assessment Strategy Phase**
- Define which activities are **formative** (non-graded) vs **summative** (graded)
- Recommend **2-3 summative learning evidence** maximum
- Ensure clear differentiation between assessment types

#### 3. **Evidence Matrix Development**
Create matrix with **10 columns** for each unit (unit total must equal 100%):
- **Column 1**: Activity name
- **Column 2**: Evidence/product
- **Column 3**: Grading weight (%)
- **Columns 4-9**: Impact indicator analysis (A, B, C, D, E, F) - **Only include indicators that apply to the specific evidence type**
- **Column 10**: Assessment instrument type

**Impact Indicators Distribution Rules:**
- **A**: Adapts to complex situations and contexts
- **B**: Makes contributions to academic activities developed
- **C**: Proposes/explains solutions or procedures not seen in class
- **D**: Introduces resources and experiences promoting critical thinking
- **E**: Incorporates interdisciplinary knowledge and activities
- **F**: Performs work autonomously and self-regulated

**CRITICAL: Use ONLY the applicable indicators for each evidence type according to TecNM correspondence standards:**

**📚 Knowledge Evidence (Evidencias de Conocimiento)** - Use ONLY indicators:
- **Cuestionario preguntas abiertas**: A, B, F
- **Opción múltiple**: A, F
- **Completamiento breve**: A, F
- **Falso/Verdadero**: A, F
- **Relación de columnas**: A, F
- **Análisis de casos**: A, B, D, F
- **Localización/identificación**: A, F

**📄 Product Evidence (Evidencias de Producto)** - Use ALL indicators:
- **Lista de cotejo**: A, B, C, D, E, F
- **Rúbrica**: A, B, C, D, E, F

**👥 Performance/Attitude Evidence (Evidencias de Desempeño/Actitud)** - Use ALL indicators:
- **Guía de observación**: A, B, C, D, E, F
- **Entrevista**: No specific indicators

**Note**: Not all evidence types need to cover all 6 indicators. Distribute only the applicable indicators according to the evidence characteristics and TecNM official correspondence framework.

### Quick Reference Table: Evidence Types and Applicable Indicators

| **Evidence Type** | **Instrument** | **Applicable Indicators** |
|-------------------|----------------|---------------------------|
| **📚 Knowledge** | Cuestionario preguntas abiertas | A, B, F |
| **📚 Knowledge** | Opción múltiple | A, F |
| **📚 Knowledge** | Completamiento breve | A, F |
| **📚 Knowledge** | Falso/Verdadero | A, F |
| **📚 Knowledge** | Relación de columnas | A, F |
| **📚 Knowledge** | Análisis de casos | A, B, D, F |
| **📚 Knowledge** | Localización/identificación | A, F |
| **📄 Product** | Lista de cotejo | A, B, C, D, E, F |
| **📄 Product** | Rúbrica | A, B, C, D, E, F |
| **👥 Performance/Attitude** | Guía de observación | A, B, C, D, E, F |
| **👥 Performance/Attitude** | Entrevista | No specific indicators |

#### 4. **Activity Overview Phase**
**IMPORTANT**: In the instructional design document, activities should be described at a HIGH LEVEL only:
- **Activity name** and **general purpose**
- **Brief description** (1-2 sentences maximum)
- **Expected evidence/product type**
- **Assessment instrument** to be used

**DO NOT include detailed instructions, step-by-step processes, or specific procedures in the instructional design. These details should be developed separately when creating individual teaching or assessment activities.**

#### 5. **Evidence Development Phase**
- Create **authentic assessment scenarios** that mirror professional contexts
- Design **portfolio-based evidence** with screenshots + reflection when applicable
- Ensure **visual evidence** and command outputs for technical practices
- **Note**: Detailed evidence specifications should be developed in separate activity files

#### 6. **Assessment Instrument Creation Phase**
**Primary Instrument: Rubrics** (4-level scale)
- **Excelente (3)**: Exceeds expectations
- **Bueno (2)**: Meets expectations
- **Aceptable (1)**: Basic level achieved
- **Insuficiente (0)**: Below minimum standard

**Secondary Instruments:**
- **Lista de Cotejo**: For specific requirement verification
- **Guía de Observación**: For performance and process evaluation

### Document Separation Guidelines:

#### **Diseño_Instruccional.md - What to Include:**
- **High-level activity descriptions** (name, purpose, evidence type)
- **Evidence matrices** with weights and impact indicators
- **Assessment instrument types** (rúbrica, lista de cotejo)
- **General methodological approach** and competencies
- **Hexagon model evaluation framework**

#### **Activity Files (Actividad*.md, Practica*.md) - What to Include:**
- **Detailed step-by-step instructions**
- **Specific procedures and processes**
- **Resource requirements and materials**
- **Time allocations and deliverable specifications**
- **Support materials and troubleshooting guides**

#### **Assessment Files (A*.md, Rubrica*.md) - What to Include:**
- **Complete rubrics with detailed criteria**
- **Specific checklists with measurable items**
- **Observation guides with behavioral indicators**
- **Scoring procedures and feedback templates**

### Quality Assurance Checklist:
- [ ] Gagné's 9 Events model applied
- [ ] Hexagon Model dimensions documented (¿Qué?, ¿Por qué?, ¿Cómo?, ¿Con qué?, ¿Cuándo?, ¿Quién?)
- [ ] Active methodologies prioritized over traditional lectures (max 20-30%)
- [ ] Evidence matrix totals 100% per unit with appropriate indicator distribution
- [ ] Assessment instruments include detailed criteria and levels
- [ ] Activities promote both technical and socio-emotional competencies
- [ ] Ethical AI use guidelines included where applicable
- [ ] Interdisciplinary connections established
- [ ] Autonomous and self-regulated learning fostered
- [ ] Impact indicators A-F distributed ONLY according to TecNM official correspondence (see Quick Reference Table)
- [ ] Knowledge evidence uses only applicable indicators: A, F (plus B, D for case analysis)
- [ ] Product evidence uses all indicators: A, B, C, D, E, F
- [ ] Performance/Attitude evidence uses all indicators: A, B, C, D, E, F

### Flexible Learning Environment Design:
- **Respond to student diversity** through varied activity formats
- **Promote collaborative projects** with defined roles and accountability
- **Foster leadership and teamwork** through participation-based activities
- **Develop critical thinking** through problem-solving scenarios
- **Balance technical competencies** with soft skills development

## Laboratory Practice Planning Template

When generating laboratory practice planning documents (Planeación de Prácticas de Laboratorio), use this structured approach:

### Template: Laboratory Practice Planning

**CRITICAL: Laboratory practice planning MUST be coherent with:**
1. **Official Program** - Extract competencies and topics exactly
2. **Instructional Design** - Align with evidence matrix and assessment calendar
3. **Resource availability** - Consider institutional limitations and requirements

### Required Document Structure:

```markdown
# Planeación de Prácticas de Laboratorio - [Subject Name]

**Fecha:** [City], [State] a [Day] de [Month] de [Year]

**Para:** C. [Laboratory Head Name]  
**Jefe(a) de Laboratorio de:** [Laboratory Name]  
**Presente**

Con base a lo establecido por el Departamento de [Department Name] con base a la planeación del curso, anexo la relación de prácticas de Laboratorio, así como las fechas tentativas a efectuarse durante el semestre [Semester Period].

## 📋 Información General
[Administrative data table]

## 🔬 Relación de Prácticas Programadas
[Practices table with dates, units, and resources]

## 🎯 Competencias a Desarrollar por Práctica
[Competency alignment by unit]

**ATENTAMENTE**
**[Teacher Name]**
```

### Practice Planning Guidelines:
- **Sequential numbering** by learning progression
- **Realistic scheduling** across 16-18 week semester
- **Resource optimization** across multiple practices  
- **Competency alignment** with official program
- **Buffer time** for complex implementations


# Template: Laboratory Practice Planning (Planeación de Prácticas de Laboratorio)

## Template Structure for Laboratory Practice Planning:

```markdown
# Planeación de Prácticas de Laboratorio - [Subject Name]

**Fecha:** [City], [State] a [Day] de [Month] de [Year]

**Para:** C. [Laboratory Head Name]  
**Jefe(a) de Laboratorio de:** [Laboratory Name]  
**Presente**

Con base a lo establecido por el Departamento de [Department Name] con base a la planeación del curso, anexo la relación de prácticas de Laboratorio, así como las fechas tentativas a efectuarse durante el semestre [Semester Period].

---

## 📋 Información General

| **Campo** | **Información** |
|-----------|-----------------|
| **Materia** | [Subject Full Name] |
| **Carrera** | [Career Program] |
| **Clave** | [Subject Code] |
| **Horario** | [Schedule Hours] |
| **Grupo** | [Group Code] |
| **Semestre** | [Academic Period] |

---

## 🔬 Relación de Prácticas Programadas

| **No.** | **Nombre de la Práctica** | **Fecha Tentativa** |  **Necesidades/Recursos** |
|---------|---------------------------|---------------------|---------------------------|
| 1 | [Practice Name] | [Date] | [Unit #] | [Summarized Required Resources] |
| 2 | [Practice Name] | [Date] | [Unit #] | [Summarized Required Resources] |
| ... | ... | ... | ... |


---

**En espera de haber cumplido con las expectativas propuestas, quedo de usted.**

**ATENTAMENTE**

**[Teacher Name]**  
**NOMBRE Y FIRMA**
```

## Instructions for Laboratory Practice Planning Generation:

### Required Information to Collect:
1. **Administrative Data:**
   - Subject name and code
   - Teacher name
   - Laboratory head name
   - Academic period/semester
   - Group code and schedule

2. **Practice Information (Extract from Official Program and Instructional Design):**
   - Practice names aligned with unit competencies
   - Sequential numbering by unit
   - Realistic scheduling across semester
   - Required resources and equipment

3. **Resource Requirements:**
   - Hardware specifications (RAM, processors, etc.)
   - Software requirements
   - Internet connectivity needs
   - Special equipment or materials

### Practice Planning Rules:

#### **Coherence Requirements:**
- **MUST align with Official Program** competencies and topics
- **MUST match Instructional Design** evidence matrix
- **MUST follow logical learning progression**
- **MUST consider prerequisite knowledge**

#### **Scheduling Guidelines:**
- **Distribute evenly** across semester weeks
- **Group by units** for logical sequence
- **Allow buffer time** between complex practices
- **Consider holiday periods** and institutional calendar

#### **Resource Planning:**
- **Specify minimum requirements** for all practices
- **Note special needs** for specific practices
- **Include software licensing** requirements
- **Consider scalability** for group sizes

#### **Practice Naming Convention:**
- Use **descriptive, professional names**
- **Align with competency objectives**
- **Indicate complexity level** when appropriate
- **Follow institutional standards**

### Quality Validation Checklist:
- [ ] All practices align with official program competencies
- [ ] Scheduling is realistic and evenly distributed
- [ ] Resource requirements are clearly specified
- [ ] Practice names are professional and descriptive
- [ ] Prerequisites are respected in sequencing
- [ ] Buffer time included for complex practices
- [ ] Administrative information is complete
- [ ] Format follows institutional standards

### Integration with Other Documents:
- **Cross-reference** with Instructional Design evidence matrix
- **Align practice dates** with assessment calendar  
- **Coordinate** with other subject laboratory schedules
- **Ensure** resource availability across programs