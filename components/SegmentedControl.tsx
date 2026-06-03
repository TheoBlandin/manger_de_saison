import { Colors } from "@/constants/Colors";
import React, { useEffect, useState } from "react";
import { View, StyleSheet, Pressable } from "react-native";
import Animated, {
    useSharedValue,
    withSpring,
  } from "react-native-reanimated";
import { BBodyText } from "./texts/body/BBodyText";

export const SegmentedControl = React.memo(function SegmentedControl({
  values,
  selected,
  onChange,
  isFirstRender,
  updateFirstRender
}: {
  values: string[];
  selected: number;
  onChange: (newVal: number) => void;
  isFirstRender: boolean;
  updateFirstRender: (val: boolean) => void;
}) {
  const [containerWidth, setContainerWidth] = useState(0);
  const translateX = useSharedValue(0);

  useEffect(() => {
    if (!containerWidth) return;

    const segmentWidth = containerWidth / 3;
    const target = selected * segmentWidth;

    if (isFirstRender) {
      translateX.value = target;
      updateFirstRender(false);
    } else {
      translateX.value = withSpring(target, {
        damping: 120,
        stiffness: 1100,
      });
    }
  }, [selected, containerWidth]);

  return (
    <View
      style={styles.filterContainer}
      onLayout={(e) => setContainerWidth(e.nativeEvent.layout.width - 5)}
    >
      <Animated.View
        style={[
          styles.sliderType,
          {
            width: containerWidth / 3 || 0,
            transform: [{ translateX: translateX }],
          },
        ]}
      />

      {values.map((label, index) => (
        <React.Fragment key={label}>
          <Pressable
            style={({ pressed }) => [
              styles.radioElement,
              pressed && styles.radioElementPressed,
            ]}
            onPress={() => onChange(index)}
            role="radio"
            aria-checked={index == selected}
          >
            <BBodyText>{label}</BBodyText>
          </Pressable>
          <View
            style={[
              styles.separatorContainer,
              {
                opacity:
                  index === 0 && selected === 2
                    ? 1
                    : index === 1 && selected === 0
                    ? 1
                    : 0,
              },
            ]}
          >
            <View style={styles.separator}></View>
          </View>
        </React.Fragment>
      ))}
    </View>
  );
});

const styles = StyleSheet.create({
  filterSection: {
    width: "100%",
    flexDirection: "column",
    gap: 4,
  },
  filterContainer: {
    borderColor: Colors.grey,
    borderWidth: 0.5,
    borderRadius: 8,
    padding: 2,
    flexDirection: "row",
  },
  radioElement: {
    paddingInline: 8,
    paddingBlock: 8,
    borderRadius: 6,
    flex: 1,
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
    gap: 4,
    backgroundColor: "transparent",
  },
  radioElementPressed: {
    backgroundColor: "rgba(13, 17, 13, 0.05)",
  },
  sliderType: {
    position: "absolute",
    top: 2,
    bottom: 2,
    left: 2,
    borderRadius: 6,
    backgroundColor: Colors.primary,
  },
  sliderPreference: {
    position: "absolute",
    top: 2,
    bottom: 2,
    left: 2,
    borderRadius: 6,
    backgroundColor: Colors.primary,
  },
  separatorContainer: {
    paddingBlock: 4,
  },
  separator: {
    backgroundColor: Colors.grey,
    width: 1,
    flex: 1,
  },
});
