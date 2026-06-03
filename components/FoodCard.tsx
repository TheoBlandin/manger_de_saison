// Design
import { Colors } from "@/constants/Colors";
import { BBodyText } from "./texts/body/BBodyText";
import { DBodyText } from "./texts/display/DBodyText";

// React
import { Pressable, StyleSheet, View } from "react-native";
import React, { useMemo } from "react";

// Assets
import DefaultFood from "./../assets/food/abricot.svg";
import { foodImages } from "./../assets/foodImages";
import Like from "./../assets/icons/like.svg";
import Dislike from "./../assets/icons/dislike.svg";

export const FoodCard = React.memo(function FoodCard({
  name,
  img,
  type,
  onPress,
  isLiked,
  isDisliked,
}: {
  name: string;
  img: string;
  type: string;
  onPress: () => void;
  isLiked: boolean;
  isDisliked: boolean;
}) {
  const FoodImage = useMemo(
    () =>
      foodImages[img as keyof typeof foodImages] ??
      DefaultFood,
    [img]
  );

  return (
    <Pressable
      style={({ pressed }) => [styles.card, pressed && styles.cardPressed]}
      onPress={onPress}
    >
      <View
        style={[
          styles.cardHeader,
          (isLiked || isDisliked) &&
            styles.cardHeaderWithPreference,
        ]}
      >
        <DBodyText style={type == "Légume" ? styles.vegetable : styles.fruit}>
          {type.charAt(0).toUpperCase()}
        </DBodyText>
        {isLiked && <Like height={24} width={24} color={Colors.like} />}
        {isDisliked && (
          <Dislike height={24} width={24} color={Colors.dislike} />
        )}
      </View>
      <FoodImage width={64} height={64} />
      <View style={styles.nameContainer}>
        <BBodyText style={styles.name}>{name}</BBodyText>
      </View>
    </Pressable>
  );
});

const styles = StyleSheet.create({
  card: {
    flexDirection: "column",
    alignItems: "center",
    gap: 4,
    padding: 4,
    borderRadius: 8,
    shadowColor: Colors.textDefault,
    shadowOffset: { width: 0, height: 0 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    flex: 1 / 3,
    margin: 4,
    backgroundColor: Colors.surface,
  },
  cardPressed: {
    backgroundColor: Colors.surfaceActive,
  },
  cardHeader: {
    flexDirection: "row",
    width: "100%",
    height: 24,
    alignItems: "center",
    justifyContent: "flex-start"
  },
  cardHeaderWithPreference: {
    justifyContent: "space-between"
  },
  vegetable: {
    color: Colors.vegetable,
  },
  fruit: {
    color: Colors.fruit,
  },
  nameContainer: {
    height: 45,
    justifyContent: "center",
    alignItems: "center",
  },
  name: {
    textAlign: "center",
  },
});
