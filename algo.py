import random
import numpy as np
import matplotlib.pyplot as plt

# Define the problem
num_routers = 3
room_width = 10
room_height = 10
signal_strength_data = [(2, 3, 0.8), (7, 5, 0.7), (1, 8, 0.6), (8, 2, 0.9)]
num_users = 50

# Generate random user positions
user_positions = []
for i in range(num_users):
    user_positions.append((random.uniform(0, room_width), random.uniform(0, room_height)))

# Define the signal strength function
def calculate_signal_strength(router_position, user_position):
    distance = np.sqrt((router_position[0] - user_position[0])*2 + (router_position[1] - user_position[1])*2)
    return sum([signal_strength / (distance**2) for (x, y, signal_strength) in signal_strength_data])

# Define the objective function
def total_coverage_area(router_positions):
    coverage_area = 0
    for user_position in user_positions:
        max_signal_strength = 0
        for router_position in router_positions:
            signal_strength = calculate_signal_strength(router_position, user_position)
            if signal_strength > max_signal_strength:
                max_signal_strength = signal_strength
        coverage_area += max_signal_strength
    return coverage_area

# Define the simulated annealing algorithm
def simulated_annealing(initial_solution, objective_function, max_iterations=1000, temperature=100, cooling_rate=0.01):
    current_solution = initial_solution
    current_score = objective_function(current_solution)
    best_solution = current_solution
    best_score = current_score
    for iteration in range(max_iterations):
        temperature *= 1 - cooling_rate
        candidate_solution = [(x + random.uniform(-1, 1), y + random.uniform(-1, 1)) for (x, y) in current_solution]
        candidate_score = objective_function(candidate_solution)
        delta_score = candidate_score - current_score
        acceptance_probability = np.exp(-delta_score / temperature)
        if delta_score < 0 or random.random() < acceptance_probability:
            current_solution = candidate_solution
            current_score = candidate_score
        if current_score > best_score:
            best_solution = current_solution
            best_score = current_score
    return (best_solution, best_score)

# Use simulated annealing to find the best router positions
initial_solution = [(random.uniform(0, room_width), random.uniform(0, room_height)) for i in range(num_routers)]
best_solution, best_score = simulated_annealing(initial_solution, total_coverage_area)

# Create a heatmap
x, y, z = [], [], []
for i in range(num_users):
    x.append(user_positions[i][0])
    y.append(user_positions[i][1])
    signal_strength = max([calculate_signal_strength(router_position, user_positions[i]) for router_position in best_solution])
    z.append(signal_strength)

plt.scatter(x, y, c=z, cmap='viridis', edgecolors='none')
for router_position in best_solution:
    plt.plot(router_position[0], router_position[1], marker='x', color='red', markersize=10)
plt.colorbar()
plt.show()