// Continuous IV and DV

data {
  int<lower=0> N;
  vector[N] h;
  vector[N] w;
}

parameters{
  real alpha;
  real<lower=0,upper=1> beta;
  real<lower=0,upper=5> sigma;
}

// McElreath Output
// model{
//  vector[N] mu;
//  alpha ~ normal(0, 10);
//  for( i in 1:N){
//    mu[i] = alpha + beta *w [i];
//  }
//  w ~ normal(mu, sigma);
// }

// VECTORIZED version, more conscise, much faster
model {
  w ~ normal(alpha + beta * h, sigma );
}

// UNVECTORIZED
//for (n in 1:N){
//  w[n] ~ normal(alpha + beta * height[n], sigma)
//}

generated quantities{
  vector[N] mu;
  for( i in 1:N){
    mu[i] = alpha + beta * h[i];
  }
}

// DJB: 16 Jan, 2024
