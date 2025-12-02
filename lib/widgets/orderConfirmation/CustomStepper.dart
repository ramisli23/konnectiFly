import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep; // 0 = Shopping cart, 1 = Checkout, 2 = Complete

  const CustomStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Colors.white, // Optionnel : fond blanc si tête
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStep(
            stepNumber: 1,
            label: "Shopping cart",
            isCompleted: currentStep > 0,
            isCurrent: currentStep == 0,
          ),
          _buildLine(isActive: currentStep > 0),
          _buildStep(
            stepNumber: 2,
            label: "Checkout details",
            isCompleted: currentStep > 1,
            isCurrent: currentStep == 1,
          ),
          _buildLine(isActive: currentStep > 1),
          _buildStep(
            stepNumber: 3,
            label: "Order complete",
            isCompleted: false,
            isCurrent: currentStep == 2,
            isDisabled: currentStep < 2,
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required int stepNumber,
    required String label,
    required bool isCompleted,
    required bool isCurrent,
    bool isDisabled = false,
  }) {
    Color activeColor = Colors.blue;
    Color disabledColor = Colors.grey.shade300;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor:
              isCompleted || isCurrent ? activeColor : disabledColor,
          radius: 20,
          child:
              isCompleted
                  ? const Icon(Icons.check, color: Colors.white)
                  : Text(
                    "$stepNumber",
                    style: TextStyle(
                      color: isDisabled ? Colors.grey : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDisabled ? Colors.grey : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLine({required bool isActive}) {
    return Container(
      width: 30,
      height: 2,
      color: isActive ? Colors.blue : Colors.grey.shade300,
    );
  }
}
