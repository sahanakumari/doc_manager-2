import 'package:doc_manager/core/utils/app_styles.dart';
import 'package:doc_manager/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class SDrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const SDrawerItem(
      {Key? key,
      required this.label,
      required this.icon,
      this.isSelected = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2.5,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(AppTheme.kRadius * 1.5),
                ),
                padding: const EdgeInsets.all(5),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(icon, color: Colors.white),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(AppTheme.kRadius),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                label.tr(context),
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).dividerColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
