---
title: D&D Math
---

# D&D Math

## d20 Rolls

### Average of a die roll

$$\frac{(\text{min} + \text{max})}{2}$$

Die | Average
----+--------
d4  | 2.5
d6  | 3.5
d8  | 4.5
d10 | 5.5
d12 | 6.5
d20 | 10.5

### Average of a die roll with advantage (n faces)

$$\frac{2}{3n} + \frac{1}{2} - \frac{1}{6n}$$

(Equals 13.825 for a d20.)

### Average of a die roll with disadvantage (n faces)

$$\frac{n}{3} + \frac{1}{2} + \frac{1}{6n}$$

(Equals 7.175 for a d20.)

## Accuracy

Note that accuracy is bounded within 0.05 to 0.95 (without advantage/disadvantage), because natural 1s always miss and 20s always hit. An attack roll that ties with AC hits. The math for passing an ability check or saving throw is the same as for landing an attack, using the DC instead of the enemy AC. Ability checks and saves are bounded within 0 to 1, with no automatic success or failures on natural 20s or 1s.

Chance to hit and chance to miss can be converted from one to the other by subtracting the chance from 1.

See these in action [here](https://www.desmos.com/calculator/ztkuvo32nt).

### Chance to hit

$$\frac{21 + \text{mods} - \text{AC}}{20}$$

### Chance to miss

$$\frac{\text{AC} - \text{mods} - 1}{20}$$


### Chance to hit (advantage)

$$1 - (\text{chance to miss})^2$$

### Chance to hit (disadvantage)

$$(\text{chance to hit})^2$$

### Average damage per round

$$\text{number of attacks} \times \left\lbrack (\text{chance to hit} \times \text{dmg per attack}) + (\text{crit chance} \times \text{dmg dice per attack}) \right\rbrack$$

If your attacks have varying accuracy or damage per hit, compute the attacks individually and add them together instead of multiplying by the number of attacks. Crit chance is typically $\frac{1}{20} = 0.05$ normally, $1 - \frac{19}{20}^2 = 0.0975$ with advantage, $\frac{1}{20}^2 = 0.0025$ with disadvantage. "Super advantage" (highest of 3d20, e.g. with Lucky or Elven Accuracy) is $1 - \frac{19}{20}^3 = 0.142625$.

See this in action [here](https://www.desmos.com/calculator/nionuv71sl) (crits omitted for ease of use).

## Monster Stats

Averages inferred from the Monster Manual by [Blog of Holding](https://blogofholding.com/?p=7338).

### Average monster AC

$$13 + \frac{\text{CR}}{3}$$

### Average attack bonus

$$4 + \frac{\text{CR}}{2}$$

### Average save DC

$$11 + \frac{\text{CR}}{2}$$

## Miscellaneous

### Proficiency bonus (level or CR)

$$2 + \left\lfloor\frac{x-1}{4}\right\rfloor$$
