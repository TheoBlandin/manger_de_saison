// Design
import { Colors } from "@/constants/Colors";

// React
import { StyleSheet, Pressable } from "react-native";

import {
  SlidersVertical,
  Search,
  ChevronLeft,
  ChevronRight,
  X,
  ArrowLeft,
  Star,
} from "lucide-react-native";
import React from "react";

const ICONS_MAP: Record<string, any> = {
  slidersVertical: SlidersVertical,
  search: Search,
  chevronRight: ChevronRight,
  chevronLeft: ChevronLeft,
  x: X,
  arrowLeft: ArrowLeft,
  star: Star,
};

export const IconButton = React.memo(function IconButton({
  iconName,
  label,
  onPress,
}: {
  iconName: string;
  label: string;
  onPress: () => void;
}) {

  const IconComponent = ICONS_MAP[iconName] || Star; // Star fallback

  return (
    <Pressable
      style={({ pressed }) => [styles.button, pressed && styles.buttonPressed]}
      onPress={onPress}
      accessibilityLabel={label}
      hitSlop={4}
    >
      <IconComponent size={24} color={Colors.textDefault} />
    </Pressable>
  );
});

const styles = StyleSheet.create({
  button: {
    padding: 8,
    borderRadius: 8,
    backgroundColor: "transparent",
  },
  buttonPressed: {
    backgroundColor: "rgba(13, 17, 13, 0.05)",
  },
});
