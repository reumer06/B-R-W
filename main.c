#include <math.h>

double attackersuccessprobability(double q,int z) 
{ 
    double p = 1.0 - q;     // power of honest node
    double lambda = (double)z * (q/p); // expected number of attacks, mean of poisson distribution
    double sum = 1.0;   // complementary probability for the attacker
    double poisson = exp(-lambda); // poisson probability for lambda
    for(int k = 0; k <= z;k++){
            sum -= poisson * (1 - pow(q/p,z - k)); // Gambler Ruins formula, the core calculation
            poisson *= lambda / (k + 1); 
    }
    return sum;
}

int main()
{
    attackersuccessprobability(0.4,1);
}
