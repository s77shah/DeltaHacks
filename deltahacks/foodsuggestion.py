import cohere

# Initialize Cohere API client
co = cohere.ClientV2(api_key="3JcjPjz2HMeGravtUVl335s4pkmY8VlPDemrUx6h")
# Function to generate food ideas using the chat API
def generate_food_ideas(past_foods, feedback=None):
    messages = [
        {"role": "system", "content": "You are a helpful assistant that generates creative food ideas."},
        {"role": "user", "content": f"Based on these foods: {', '.join(past_foods)}, generate 10 new food ideas."}
    ]

    if feedback and "healthy" in feedback.lower():
        messages.append({"role": "user", "content": "Focus on healthier options like salads, plant-based dishes, and low-calorie meals."})
    elif feedback and "indulgent" in feedback.lower():
        messages.append({"role": "user", "content": "Avoid healthier items like salads, vegetables, and low-calorie foods. Focus on indulgent options like fried or cheesy dishes."})

    response = co.chat(
        model="command-r7b-12-2024-vllm",  # Use the correct model for chat
        messages=messages,
    )

    # Return the assistant's reply from the first assistant message
    return response.generations[0].text.strip()

# Main function
def main():
    print("Welcome to the Food Suggestion Generator!")
    print("Please enter 10 foods you've eaten recently.")
    
    past_foods = []
    for i in range(10):
        food = input(f"Food {i + 1}: ")
        past_foods.append(food)

    # Generate initial suggestions
    print("\nGenerating 10 food suggestions based on your input...\n")
    suggestions = generate_food_ideas(past_foods)
    print("Suggestions:\n", suggestions)

    # Ask for feedback
    feedback = input("\nDo you have any feedback? (e.g., 'More indulgent', 'Healthier options', or 'No feedback'): ")
    print("\nGenerating 10 more suggestions based on your feedback...\n")
    
    # Generate refined suggestions
    refined_suggestions = generate_food_ideas(past_foods, feedback)
    print("Refined Suggestions:\n", refined_suggestions)

# Run the main function
if __name__ == "__main__":
    main()
