Red Animalitos
```mermaid
graph TB
    subgraph "Red de Zoológico - Zaboo Mazoo"
        subgraph "Región África - 10.1.0.0/20"
            R_Africa[Router África<br/>10.1.0.1]
            SW_Africa[Switch África]
            PC_Leones[PC Leones<br/>10.1.0.10]
            PC_Elefantes[PC Elefantes<br/>10.1.0.11]
            PC_Jirafas[PC Jirafas<br/>10.1.0.12]
        end
        
        subgraph "Región Asia - 10.2.0.0/20"
            R_Asia[Router Asia<br/>10.2.0.1]
            SW_Asia[Switch Asia]
            PC_Tigres[PC Tigres<br/>10.2.0.10]
            PC_Pandas[PC Pandas<br/>10.2.0.11]
            PC_Orangutanes[PC Orangutanes<br/>10.2.0.12]
        end
        
        subgraph "Región América - 10.3.0.0/20"
            R_America[Router América<br/>10.3.0.1]
            SW_America[Switch América]
            PC_Jaguares[PC Jaguares<br/>10.3.0.10]
            PC_Osos[PC Osos<br/>10.3.0.11]
            PC_Aguila[PC Águila<br/>10.3.0.12]
        end
        
        subgraph "Región Oceanía - 10.4.0.0/20"
            R_Oceania[Router Oceanía<br/>10.4.0.1]
            SW_Oceania[Switch Oceanía]
            PC_Canguros[PC Canguros<br/>10.4.0.10]
            PC_Koalas[PC Koalas<br/>10.4.0.11]
            PC_Kiwis[PC Kiwis<br/>10.4.0.12]
        end
        
        subgraph "Red Central"
            R_Central[Router Central<br/>10.0.0.1]
            SW_Central[Switch Central]
            Server[Servidor Central<br/>10.0.0.100]
        end
    end
    
    %% Conexiones entre routers y switches
    R_Africa --> SW_Africa
    R_Asia --> SW_Asia
    R_America --> SW_America
    R_Oceania --> SW_Oceania
    R_Central --> SW_Central
    
    %% Conexiones de PCs a switches
    SW_Africa --> PC_Leones
    SW_Africa --> PC_Elefantes
    SW_Africa --> PC_Jirafas
    
    SW_Asia --> PC_Tigres
    SW_Asia --> PC_Pandas
    SW_Asia --> PC_Orangutanes
    
    SW_America --> PC_Jaguares
    SW_America --> PC_Osos
    SW_America --> PC_Aguila
    
    SW_Oceania --> PC_Canguros
    SW_Oceania --> PC_Koalas
    SW_Oceania --> PC_Kiwis
    
    SW_Central --> Server
    
    %% Conexiones entre routers (enlaces troncales)
    R_Central ---|WAN| R_Africa
    R_Central ---|WAN| R_Asia
    R_Central ---|WAN| R_America
    R_Central ---|WAN| R_Oceania
    
    %% Estilos
    classDef routerStyle fill:#ff9999,stroke:#cc0000,stroke-width:2px
    classDef switchStyle fill:#99ccff,stroke:#0066cc,stroke-width:2px
    classDef pcStyle fill:#ccffcc,stroke:#009900,stroke-width:2px
    classDef serverStyle fill:#ffcc99,stroke:#ff6600,stroke-width:3px
    
    class R_Central,R_Africa,R_Asia,R_America,R_Oceania routerStyle
    class SW_Central,SW_Africa,SW_Asia,SW_America,SW_Oceania switchStyle
    class PC_Leones,PC_Elefantes,PC_Jirafas,PC_Tigres,PC_Pandas,PC_Orangutanes,PC_Jaguares,PC_Osos,PC_Aguila,PC_Canguros,PC_Koalas,PC_Kiwis pcStyle
    class Server serverStyle

    ```