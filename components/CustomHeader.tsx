// Components
import { IconButton } from "./IconButton";

// Design
import { Colors } from "../constants/Colors";
import { BLargeText } from "./texts/body/BLargeText";

// React
import { View, StyleSheet, TextInput, TouchableOpacity } from "react-native";
import { useCallback, useRef, useState } from "react";

// Packages
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { Search } from "lucide-react-native";

export function CustomHeader({
  currentMonth,
  onPrevious,
  onNext,
  onFilters,
  onSearch,
  searchValue,
  onLayout,
}: {
  currentMonth: string;
  onPrevious: () => void;
  onNext: () => void;
  onFilters: () => void;
  onSearch: (val: string) => void;
  searchValue: string,
  onLayout: (e: any) => void;
}) {
  const insets = useSafeAreaInsets();

  const [searching, setSearching] = useState<boolean>(false);

  const inputRef = useRef<TextInput>(null);

  const handleSearch = useCallback(() => {
    setSearching(true);
  }, []);
  
  const handleBack = useCallback(() => {
    setSearching(false);
    onSearch('');
  }, [onSearch]);

  return (
    <View
      style={[styles.container, { paddingTop: insets.top }]}
      onLayout={onLayout}
    >
      {!searching ? (
        <View style={styles.content}>
          <IconButton
            iconName="slidersVertical"
            label="Filtrer"
            onPress={onFilters}
          />
          <View style={styles.monthPicker}>
            <IconButton
              iconName="chevronLeft"
              label="Mois précédent"
              onPress={onPrevious}
            />
            <BLargeText>{currentMonth}</BLargeText>
            <IconButton
              iconName="chevronRight"
              label="Mois suivant"
              onPress={onNext}
            />
          </View>
          <IconButton
            iconName="search"
            label="Rechercher"
            onPress={handleSearch}
          />
        </View>
      ) : (
        <View style={styles.content}>
          <IconButton
            iconName="arrowLeft"
            label="Retour"
            onPress={handleBack}
          />
          <TouchableOpacity
            style={styles.searchbar}
            onPress={() => inputRef.current?.focus()}
          >
            <Search size={24} color={Colors.textDefault} />
            <TextInput
              ref={inputRef}
              value={searchValue}
              style={styles.textinput}
              placeholder="Rechercher un aliment"
              placeholderTextColor={Colors.grey}
              cursorColor={Colors.textDefault}
              onChangeText={onSearch}
              autoFocus
            />
            <IconButton iconName="x" label="Effacer" onPress={() => onSearch('')} />
          </TouchableOpacity>
        </View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: Colors.primary,
    zIndex: 1000,
    width: "100%",
  },
  content: {
    paddingBlock: 8,
    paddingHorizontal: 12,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    gap: 8,
  },
  monthPicker: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    flex: 1,
    paddingVertical: 4,
  },
  searchbar: {
    paddingHorizontal: 12,
    paddingVertical: 4,
    backgroundColor: Colors.surface,
    borderRadius: 8,
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    gap: 8,
  },
  textinput: {
    fontFamily: "Fredoka_400Regular",
    fontSize: 16,
    lineHeight: 16 * 1.4,
    color: Colors.textDefault,
    flex: 1,
    width: "100%",
    padding: 0,
  },
});
