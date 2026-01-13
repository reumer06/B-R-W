#include <math.h>
#include <stdio.h>

double attackersuccessprobability(double q,int z) 
{
    if (q >= 0.5) return 1.0; // If attacker has 50% or more,he will eventually win
    if (q <= 0.0) return 0.0;
    
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
    double q = 0.3;
    printf("Attacker success probability (q=%.2f):\n",q);

    for(int z = 0;z <=10;++z){
        printf("z= %2d: Probability = %f\n",z,attackersuccessprobability(q,z));
    }
}
