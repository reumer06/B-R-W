#set page(paper: "a4", margin: 1in)
#set text(font: "Linux Libertine", size: 11pt)


= The Binomial Random Walk

In the Bitcoin whitepaper, Satoshi Nakamoto models the vulnerability of the network to a double-spending attack as a stochastic process. Specifically, the race between an honest chain and an attacker’s secret chain is characterized as a *Binomial Random Walk*.

== The Variables
- $p$: Probability that an honest node finds the next block.
- $q$: Probability that the attacker finds the next block ($p + q = 1$).
- $z$: The number of blocks (confirmations) the honest chain has progressed.
- $q_z$: The probability that an attacker will ever catch up from $z$ blocks behind.

== The Gambler's Ruin Formula
The core of this analysis relies on the classic **Gambler's Ruin** problem. In this scenario, a gambler (the attacker) starts with a deficit and bets against an entity with infinite wealth (the honest network). 

The probability $q_z$ is the "hitting probability" the chance that the random walk will eventually hit the origin (zero gap) despite a disadvantageous drift. It is derived from the boundary conditions of a linear recurrence relation:

$ q_z = cases(
  1 & "if" p <= q,
  (q/p)^z & "if" p > q
) $

This formula shows that if the attacker has less than 50% of the hashrate ($p > q$), their probability of success decreases **exponentially** as the lead $z$ increases.

== The Poisson Approximation
Because the attacker mines simultaneously with the honest network, the number of blocks the attacker finds by the time the honest nodes reach $z$ blocks is not fixed. It follows a *Poisson Distribution* with an expected value $lambda$:

$ lambda = z (q/p) $

== Total Success Probability
To find the total probability of the attacker overtaking the chain, we sum the Poisson probability of the attacker finding $k$ blocks multiplied by the **Gambler's Ruin** probability of catching up the remaining distance $(z - k)$:

$ P = sum_{k=0}^{infinity} frac(lambda^k e^(-lambda), k!) dot cases(
  (q/p)^(z-k) & "if" k <= z,
  1 & "if" k > z
) $


#pagebreak()
== Security Implications
This model justifies why Bitcoin users wait for multiple confirmations. As $z$ grows, the "Gambler" (attacker) is increasingly likely to be "Ruined" by the honest network's majority power.

#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: center,
  table.header([*Confirmations ($z$)*], [*Success Probability ($q=0.3$)*]),
  [0], [1.0000],
  [1], [0.4162],
  [2], [0.2320],
  [5], [0.0573],
  [10], [0.0061],
)

---
== References
- Nakamoto, S. (2008). _Bitcoin: A Peer-to-Peer Electronic Cash System._
- #link("https://en.wikipedia.org/wiki/Random_walk")[Random walk - Wikipedia]
- #link("https://math.stackexchange.com/questions/3157543/binomial-random-walks-and-bitcoin")[Binomial Random Walks and Bitcoin - Mathematics Stack Exchange]