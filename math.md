---
title: D&D Math
---

## Dice Probability

### Single die

When rolling a single die with $k$ sides, the probability of any given outcome is $\frac{1}{k}$.

### Multiple dice

#### $k$th Value

If $F$ is the CDF of one $m$-sided die and you roll $n$ of those dice, the CDF for the $k$th highest roll is

$$\sum_{j=1}^{k} (-1)^{k+j} \binom{n - j}{k - j} \binom{n}{j - 1} F^{n + 1 - j}$$

```anydice
output K@NdM
```

Applying this formula can be done using a little bit of linear algebra. For example, to find the expected value of the 3rd lowest roll of 4d6, you can treat the CDF as a list of probabilities:

$$\left[\frac{1}{6}, \frac{2}{6}, \frac{3}{6}, \frac{4}{6}, \frac{5}{6}, \frac{6}{6}\right]$$

Then, use the formula to find the coefficients of a polynomial:

$$(-1)^{3+1} \binom{4-1}{3-1} \binom{4}{1-1} = 3$$
$$(-1)^{3+2} \binom{4-2}{3-2} \binom{4}{2-1} = -8$$
$$(-1)^{3+3} \binom{4-3}{3-3} \binom{4}{3-1} = 6$$

This gives the polynomial $f(x) = 3x^4 - 8x^3 + 6x^2$. Apply this function $f$ to each value in our "CDF":

$$\left[f\left(\frac{1}{6}\right), f\left(\frac{2}{6}\right), f\left(\frac{3}{6}\right), f\left(\frac{4}{6}\right), f\left(\frac{5}{6}\right), f\left(\frac{6}{6}\right)\right] = \left[\frac{19}{144}, \frac{11}{27}, \frac{11}{16}, \frac{8}{9}, \frac{425}{432}, 1\right]$$

Then take the pairwise differences (subtract from each value the value to its left, or 0 in the case of the first value):

$$\left[\frac{19}{144}, \frac{119}{432}, \frac{121}{432}, \frac{29}{144}, \frac{41}{432}, \frac{7}{432}\right]$$

And take the dot product of this vector with the vector $[1, 2, 3, 4, 5, 6]$, which yields $\frac{1253}{432} \approx 2.90046$.

#### Highest value (advantage)

The probability of the highest roll out of $n$ rolls of $k$-sided dice equaling some value $x$ is given by

$$p(x; n, k) = \frac{x^n - (x-1)^n}{k^n}$$

```anydice
output [highest 1 of NdK] = X
output 1@NdK = X    \ Alternative syntax \
```

#### Lowest value (disadvantage)

The probability of the lowest roll out of $n$ rolls of $k$-sided dice equaling some value $x$ is given by

$$p(x; n, k) = \frac{(k-x+1)^n - (k-x)^n }{k^n} $$

```anydice
output [lowest 1 of NdK] = X
output N@NdK = X    \ Alternative syntax \
```

For advantage and disadvantage, these formulae can be applied with $n = 2$ and $k = 20$. The following table shows the values of these distributions.

Roll ($x$) | Advantage | Disadvantage
--------:+:---------:+:------------:
 1       | 0.0025    | 0.0975
 2       | 0.0075    | 0.0925
 3       | 0.0125    | 0.0875
 4       | 0.0175    | 0.0825
 5       | 0.0225    | 0.0775
 6       | 0.0275    | 0.0725
 7       | 0.0325    | 0.0675
 8       | 0.0375    | 0.0625
 9       | 0.0425    | 0.0575
10       | 0.0475    | 0.0525
11       | 0.0525    | 0.0475
12       | 0.0575    | 0.0425
13       | 0.0625    | 0.0375
14       | 0.0675    | 0.0325
15       | 0.0725    | 0.0275
16       | 0.0775    | 0.0225
17       | 0.0825    | 0.0175
18       | 0.0875    | 0.0125
19       | 0.0925    | 0.0075
20       | 0.0975    | 0.0025

#### Sum of values

The probability of getting the sum $x$ from $n$ rolls of $k$-sided dice is given by

$$P(x; n, k) = \frac{1}{k^n} \times \sum_{i=0}^{i_{\text{max}}} (-1)^i \binom{n}{i} \binom{x - ki - 1}{x - ki - n}$$

where $i_{\text{max}} = \left\lfloor \frac{x - n}{k} \right\rfloor$.

When $n = 1$, this is a uniform distribution. When $n = 2$, it is a triangular distribution. As $n$ approaches infinity, it takes the shape of a normal distribution (bell curve). This is due to the central limit theorem.

```anydice
output NdK        \ Distribution \
output NdK = X    \ Probability  \
```

## Dice Averages

### Single die

A single die roll follows a discrete uniform distribution between its minimum and maximum value, the average of which is given by

$$\frac{(\text{min} + \text{max})}{2}$$

Common averages are shown in the table below.

Die | Average
---:+---------:
d4  | 2.5
d6  | 3.5
d8  | 4.5
d10 | 5.5
d12 | 6.5
d20 | 10.5

### Multiple dice

To get the average of the sum of multiple dice rolls, add together their individual averages.

### Two dice with advantage

When rolling two dice with $n$ sides and selecting the higher result, the average is given by

$$\frac{2n}{3} + \frac{1}{2} - \frac{1}{6n}$$

(Equals 13.825 for a d20.)

### Two dice with disadvantage

When rolling two dice with $n$ sides and selecting the lower result, the average is given by

$$\frac{n}{3} + \frac{1}{2} + \frac{1}{6n}$$

(Equals 7.175 for a d20.)

## Accuracy

Note that accuracy is bounded within 0.05 to 0.95 (without advantage or disadvantage) because natural 1s always miss and 20s always hit. An attack roll that ties with AC hits.

The math for passing an ability check or saving throw is the same as for landing an attack, using the DC instead of the enemy AC. Ability checks and saves are bounded within 0 to 1, with no automatic success or failures on natural 20s or 1s.

Chance to hit and chance to miss can be converted from one to the other by subtracting the chance from 1.

See these in action [here](https://www.desmos.com/calculator/ztkuvo32nt).

### Chance to hit

$$\frac{21 + \text{mods} - \text{AC}}{20}$$

```anydice
output d20 + MODS >= AC
```

### Chance to miss

$$1 - \text{(chance to hit)},\;\text{or}\;\frac{\text{AC} - \text{mods} - 1}{20}$$

```anydice
output d20 + MODS < AC
```

### Chance to hit (advantage)

$$1 - (\text{chance to miss})^2$$

```anydice
output [highest 1 of 2d20] + MODS >= AC
output 1@2d20 + MODS >= AC    \ Alternative syntax \
```

### Chance to hit (disadvantage)

$$(\text{chance to hit})^2$$

```anydice
output [lowest 1 of 2d20] + MODS >= AC
output 2@2d20 + MODS >= AC    \ Alternative syntax \
```

### Chance to critically hit
Your chance to crit follows the same formula as your chance to hit (normally or with advantage or disadvantage), except with $\text{mods} = 0$ and $\text{AC} = t$, where $t$ is the minimum roll you need to crit (typically 20).

$$\frac{21 - t}{20}$$

You can apply the formulae for advantage/disadvantage as needed.

```anydice
output    d20 = T    \ Normal       \
output 1@2d20 = T    \ Advantage    \
output 2@2d20 = T    \ Disadvantage \
```

### Chance to critically miss
Your chance to crit miss is the chance of rolling a natural 1 on a d20.

Normal | Advantage | Disadvantage
-------+-----------+-------------
0.05   | 0.0025    | 0.0975

### Chance to hit (including crits)
Explicitly accounting for crits and crit misses is typically not necessary in a bounded-accuracy system, since it is almost never the case that characters end up fighting creatures they can only hit with crits, or creatures they always hit except on crit misses. Nevertheless, it is possible to calculate this precisely with a few additional steps.

First, calculate your chance of [critically hitting](#chance-to-critically-hit) and [critically missing](#chance-to-critically-miss). Then, calculate [your chance of hitting without accounting for crits](#chance-to-hit). Your true chance to hit cannot be lower than your crit chance and cannot be higher than your crit miss chance; otherwise, it is the chance to hit you calculated.

$$\max(\min(P_\text{hit},\ P_\text{crit miss}),\ P_\text{crit hit})$$

If you are rolling with advantage or disadvantage, perform the above calculations as if you were rolling normally and then apply [advantage](#chance-to-hit-advantage) or [disadvantage](#chance-to-hit-disadvantage) to this value as needed.

### Average damage per round

$$N \times \left( P_\text{hit} \cdot D_\text{attack} + P_\text{crit} \cdot D_\text{crit} \right)$$

where

- $N$ is the number of attacks you make.
- $P_\text{hit}$ is your chance of hitting.
- $D_\text{attack}$ is your average damage per attack (damage dice with modifiers).
- $P_\text{crit}$ is your chance of critting.
- $D_\text{crit}$ is the average additional damage done by a crit (damage dice without modifiers).

If your attacks have varying accuracy or damage per hit, compute the attacks individually and add them together instead of multiplying by the number of attacks.

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
