import { Colors } from "@/constants/Colors";
import {
  StyleSheet,
  TouchableWithoutFeedback,
  View,
} from "react-native";
import { BLargeText } from "./texts/body/BLargeText";
import { IconButton } from "./IconButton";
import { BBodyText } from "./texts/body/BBodyText";
import { useEffect, useRef, useState } from "react";

import Animated, {
  runOnJS,
  useSharedValue,
  withSpring,
  withTiming,
} from "react-native-reanimated";
import React from "react";
import { SegmentedControl } from "./SegmentedControl";

export function FiltersModal({
  onClose,
  currentFilterType,
  currentFilterPreference,
  onChangeType,
  onChangePreference,
}: {
  onClose: () => void;
  currentFilterType: number;
  currentFilterPreference: number;
  onChangeType: (type: number) => void;
  onChangePreference: (preference: number) => void;
}) {
  const typeSegments = ["Tous", "Fruits", "Légumes"];
  const preferenceSegments = ["Tous", "J'aime", "Je n'aime pas"];

  const translateY = useSharedValue(300);

  const isFirstRender = useRef(true);

  useEffect(() => {
    translateY.value = withSpring(0, {
      damping: 120,
      stiffness: 1100,
    });
  }, []);

  const handleClose = () => {
    translateY.value = withTiming(
      300,
      {
        duration: 230,
      },
      (finished) => {
        if (finished) {
          runOnJS(onClose)();
        }
      }
    );
  };

  return (
    <TouchableWithoutFeedback onPress={handleClose}>
      <View style={styles.overlay}>
        <TouchableWithoutFeedback>
          <Animated.View
            style={[
              styles.modalView,
              { paddingBottom: 24, transform: [{ translateY: translateY }] },
            ]}
          >
            {/* Header */}
            <View style={styles.modalHeader}>
              <BLargeText>Filtres</BLargeText>
              <IconButton
                iconName="x"
                label="Fermer la fenêtre"
                onPress={handleClose}
              />
            </View>

            {/* Type */}
            <View style={styles.filterSection}>
              <BBodyText>Type</BBodyText>
              <SegmentedControl
                values={typeSegments}
                selected={currentFilterType}
                onChange={(index) => onChangeType(index)}
                isFirstRender={isFirstRender.current}
                updateFirstRender={() => isFirstRender.current = false}
              />
            </View>

            {/* Preference */}
            <View style={styles.filterSection}>
              <BBodyText>Preference</BBodyText>
              <SegmentedControl
                values={preferenceSegments}
                selected={currentFilterPreference}
                onChange={(index) => onChangePreference(index)}
                isFirstRender={isFirstRender.current}
                updateFirstRender={() => isFirstRender.current = false}
              />
            </View>
          </Animated.View>
        </TouchableWithoutFeedback>
      </View>
    </TouchableWithoutFeedback>
  );
}

const styles = StyleSheet.create({
  overlay: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    justifyContent: "flex-end",
    alignItems: "center",
    backgroundColor: Colors.overlay,
    zIndex: 9999,
  },
  modalView: {
    flexDirection: "column",
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: Colors.surface,
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
    padding: 12,
    gap: 12,
    width: "100%",
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    alignSelf: "stretch",
  },
  filterSection: {
    width: "100%",
    flexDirection: "column",
    gap: 4,
  }
});
