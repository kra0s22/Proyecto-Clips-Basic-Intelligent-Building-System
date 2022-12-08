<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://raw.githubusercontent.com/kra0s22/Proyecto-Clips-Basic-Intelligent-Building-System/master/Images/image.png" alt="Project logo"></a>
</p>

<h3 align="center">Project Title</h3>

<div align="center">

[![GitHub Issues](https://img.shields.io/github/issues/kra0s22/Proyecto-Clips-Basic-Intelligent-Building-System.svg)](https://github.com/kra0s22/Proyecto-Clips-Basic-Intelligent-Building-System/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/kra0s22/Proyecto-Clips-Basic-Intelligent-Building-System.svg)](https://github.com/kra0s22/Proyecto-Clips-Basic-Intelligent-Building-System/pulls)

</div>

---

<p align="center"> A basic intelligent building system that uses the CLIPS language to make decisions based on the information provided by the sensors.
    <br> 
</p>

## 📝 Table of Contents

- [📝 Table of Contents](#-table-of-contents)
- [🧐 About ](#-about-)
- [🎈 Usage ](#-usage-)
  - [Sensors](#sensors)
    - [Smoke sensor](#smoke-sensor)
    - [Water sensor](#water-sensor)
  - [Air Conditioning and heating system](#air-conditioning-and-heating-system)
  - [Lights switch](#lights-switch)
  - [Additional features](#additional-features)
- [🚀 Execution ](#-execution-)
- [⛏️ Built Using ](#️-built-using-)
- [✍️ Authors ](#️-authors-)

## 🧐 About <a name = "about"></a>

The project is a basic intelligent building system that uses the CLIPS language to make decisions based on the information provided by the sensors. 

## 🎈 Usage <a name="usage"></a>

The Building System is composed of 4 main parts:

- Sensors
- Air Conditioning and heating system
- Lights switch
- Additional features


### Sensors

The sensors are responsible for providing information about smoke sensors and water sensors.

#### Smoke sensor

The smoke sensor is responsible for detecting smoke in the room. The sensor detects somke in the room and sends the information to the system, which is responsible of manage the information.

```clips
(deftemplate smokesensor
    (slot name (type STRING))
    (slot description (type STRING))
    (slot activated (type INTEGER)) ; mirarlo en clips
    (slot revision (type INTEGER)) ; date last revision
    (slot smoke (type INTEGER))
)
```


#### Water sensor

The water sensor is responsible for detecting water in the room. The sensor is composed of a water level detector and a water sensor. The water level detector is responsible for detecting water level of the tnak in the roo of the building and the water sensor is responsible for sending the information to the system when it is raining, opening its valve.

```clips
(deftemplate watersensor
    (slot name (type STRING))
    (slot activated (type STRING)) ; "true" or "false"
    (slot water_level (type STRING)); empty, low, medium, high
    (slot revision (type INTEGER)) 
)
```


### Air Conditioning and heating system

The air conditioning and heating system is responsible for maintaining the temperature of the room within the desired range. It simply turns on the air conditioning or heating system when the temperature is out of range and there are at less two people in the location.

### Lights switch

The lights switch is responsible for turning on and off the lights of the room. The switch is controlled by a light sensor that is responsible for turning on the lights when the room is dark and there is at less one person on it.

### Additional features

The system has additional features that are not directly related to the sensors. These features are:

- The system turn on the lights of the hallways during the working day.
- The system turns off the lights of the hallways during the night.


## 🚀 Execution <a name = "deployment"></a>

Example of execution of the system:

![water_quality1_graph](https://raw.githubusercontent.com/kra0s22/Proyecto-Clips-Basic-Intelligent-Building-System/master/Images/run_clips.jpg)

## ⛏️ Built Using <a name = "built_using"></a>

- [CLIPS](https://www.clipsrules.net/) - Language

## ✍️ Authors <a name = "authors"></a>


> GitHub [@kra0s22](https://github.com/kra0s22) &nbsp;&middot;&nbsp;
> 
> Twitter [@kra0s22](https://twitter.com/kra0s22)

