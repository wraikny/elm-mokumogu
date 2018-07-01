module Widgets.IncrementalSearch exposing (Model, init, Msg, update, view)

import Html exposing (..)
import Html.Attributes exposing(..)
import Html.Events exposing (onInput, onClick)


-- MODEL


type alias Model = {
        word : String,
        words : List String,
        match : Match
    }


init : (Model, Cmd Msg)
init =
    (Model "" words Partial, Cmd.none)


type Match
    = Partial
    | Forward
    | Backward



-- UPDATE


type Msg
    = SearchText String
    | SwitchTo Match


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ words, word } as model) =
    case msg of
        SearchText word ->
            ( {model | word=word}, Cmd.none )
        SwitchTo match ->
            ( {model | match = match}, Cmd.none )



-- VIEW


view : Model -> Html Msg
view ({words, word} as model) =
    div [] [
        div [class "p1"] [
            input [
                placeholder "Search...",
                value word,
                onInput SearchText
            ] [],
            fieldset [] [
                model |> radio Partial "Partial",
                model |> radio Forward "Forward",
                model |> radio Backward "Backward"
            ]
        ],
        searchList model
    ]


radio : Match -> String -> Model -> Html Msg
radio match txt model =
    label [] [
        input [
            type_ "radio",
            name "match-type",
            checked (model.match == match),
            onClick <| SwitchTo match
        ] [],
        text txt
    ]


searchList : Model -> Html Msg
searchList {words, word, match} =
    ul [] (
        words
        |> List.filter (\x ->
            let z = "*" in
            let (nw, nx) = case match of
                Partial -> (word,  x)
                Forward -> (z ++ word, z ++ x)
                Backward -> (word ++ z, x ++ z)
            in
                String.contains nw nx
        )
        |> List.map (\x -> li [] [ text x ])
    )



-- SEARCH WORDS

words : List String
words =
    [ "able", "about", "according to", "account", "acid", "across", "act", "addition", "adjustment", "advertisement", "after", "again", "against", "agreement", "air", "all", "almost", "already", "also", "among", "amount", "amusement", "and", "angle", "angry", "animal", "answer", "ant", "any", "apple", "approval", "arch", "argument", "arm", "army", "around", "art", "as", "at", "attack", "attempt", "attention", "attraction", "authority", "automatic", "awake", "baby", "back", "bad", "bag", "balance", "ball", "band", "base", "basin", "basket", "bath", "be", "beautiful", "because", "bed", "bee", "before", "behaviour", "belief", "bell", "bent", "berry", "between", "bird", "birth", "bit", "bite", "bitter", "black", "blade", "blood", "blow", "blue", "board", "boat", "body", "boiling", "bone", "book", "boot", "bottle", "box", "boy", "brain", "brake", "branch", "breath", "brick", "bridge", "bright", "broken", "brother", "brown", "brush", "bucket", "building", "bulb", "burn", "burst", "business", "but", "button", "by", "cake", "camera", "card", "care", "carriage", "cart", "cat", "cause", "certain", "chain", "chance", "change", "cheap", "cheese", "chemical", "chest", "chief", "chin", "church", "circle", "clean", "clear", "clock", "cloth", "cloud", "coat", "cold", "collar", "color", "comb", "come", "comfort", "committee", "common", "company", "comparison", "competition", "complete", "complex", "condition", "connection", "conscious", "control", "cook", "copper", "copy", "cord", "cotton", "cough", "country", "cover", "cow", "crack", "credit", "crime", "cruel", "crush", "cry", "cultivate", "cup", "current", "curtain", "curve", "cushion", "cut", "damage", "danger", "dark", "data", "daughter", "day", "dead", "dear", "death", "debt", "decision", "deep", "degree", "dependent", "design", "desire", "destruction", "detail", "development", "different", "direction", "dirty", "discovery", "discussion", "disease", "disgust", "distance", "distribution", "division", "do", "dog", "door", "doubt", "down", "drain", "drawer", "dress", "drink", "driving", "drop", "dry", "dust", "ear", "early", "earth", "east", "economic", "edge", "education", "effect", "egg", "elastic", "electric", "end", "engine", "enough", "equal", "error", "even", "event", "ever", "every", "example", "exchange", "existence", "expansion", "experience", "expert", "eye", "face", "fact", "fall", "family", "far", "farm", "fat", "father", "fear", "feather", "feeble", "feeling", "female", "fertile", "fiction", "field", "fight", "financial", "finger", "fire", "first", "fish", "fixed", "flag", "flame", "flat", "flight", "floor", "flower", "fly", "fold", "food", "foolish", "foot", "for", "force", "fork", "form", "forward", "fowl", "frame", "free", "frequent", "friend", "from", "front", "fruit", "full", "future" ] ++ [ "garden", "general", "get", "girl", "give", "glass", "glove", "go", "goat", "gold", "good", "government", "grain", "grass", "gray", "great", "green", "grip", "group", "growth", "guide", "gun", "hair", "hammer", "hand", "hanging", "happy", "harbor", "hard", "harmony", "hat", "hate", "have", "head", "healthy", "hearing", "heart", "heat", "help", "here", "high", "history", "hole", "hollow", "hook", "hope", "horn", "horse", "hospital", "hour", "house", "how", "humor", "ice", "idea", "if", "ill", "important", "impulse", "in", "increase", "industry", "information", "ink", "insect", "instrument", "insurance", "interest", "international", "into", "invention", "iron", "island", "jelly", "jewel", "join", "journey", "judge", "jump", "keep", "kettle", "key", "kick", "kind", "kiss", "knee", "knife", "knot", "knowledge", "land", "language", "last", "late", "laugh", "law", "lead", "leaf", "learning", "left", "leg", "let", "letter", "level", "library", "lift", "light", "like", "limit", "line", "lip", "liquid", "list", "little", "living", "lock", "long", "look", "loose", "loss", "loud", "love", "low", "machine", "make", "male", "man", "manager", "map", "mark", "market", "married", "mass", "match", "material", "may", "meal", "measure", "meat", "medical", "meeting", "memory", "metal", "middle", "military", "milk", "mind", "mine", "minute", "mist", "mixed", "mobile", "money", "monkey", "month", "moon", "morning", "mother", "motion", "mountain", "mouth", "move", "much", "muscle", "music", "nail", "name", "narrow", "nation", "natural", "near", "necessary", "neck", "need", "needle", "nerve", "net", "new", "news", "night", "no", "noise", "normal", "north", "nose", "note", "now", "number", "nuts", "observation", "of", "off", "offer", "office", "oil", "old", "on", "only", "open", "operation", "opinion", "opposite", "or", "orange", "order", "organization", "ornament", "other", "out", "oven", "over", "owner", "page", "pain", "paint", "paper", "parallel", "parcel", "part", "past", "paste", "payment", "peace", "pen", "pencil", "person", "physical", "picture", "pig", "pin", "pipe", "place", "plane", "plant", "plate", "play", "please", "pleasure", "pocket", "point", "poison", "polish", "political", "poor", "porter", "position", "possible", "pot", "potato", "powder", "power", "present", "president", "price", "print", "prison", "private", "probable", "process", "produce", "profit", "property", "prose", "protest", "public", "pull", "pump", "punishment", "purpose", "push", "put", "quality", "question", "quick", "quiet", "quite", "rail", "rain", "range", "rat", "rate", "ray", "reaction", "reading", "ready", "reason", "receipt", "record", "red", "regret", "regular", "relation", "religion", "representative", "request", "respect", "responsible", "rest", "reward", "rhythm", "rice", "right", "ring", "river", "road", "rod", "roll", "roof", "room", "root", "rough", "round", "rub", "rule", "run", "sad", "safe", "sail", "salt", "same", "sand", "say", "scale", "school", "science", "scissors", "screw", "sea", "seat", "second", "secret", "secretary", "see", "seed", "seem", "selection", "self", "send", "sense", "separate", "serious", "servant", "sex", "shade", "shake", "shame", "sharp", "sheep", "shelf", "ship", "shirt", "shock", "shoe", "short", "shut", "side", "sign", "silk", "silver", "simple", "sister", "size", "skin", "skirt", "sky", "sleep", "slip", "slope", "slow", "small", "smash", "smell", "smile", "smoke", "smooth", "snake", "sneeze", "snow", "so", "soap", "social", "society", "sock", "soft", "solid", "some", "son", "song", "sort", "sound", "soup", "south", "space", "spade", "special", "sponge", "spoon", "spring", "square", "stage", "stamp", "star", "start", "statement", "station", "steam", "steel", "stem", "step", "stick", "sticky", "stiff", "still", "stitch", "stocking", "stomach", "stone", "stop", "store", "story", "straight", "strange", "street", "stretch", "strong", "structure", "substance", "such", "sudden", "sugar", "suggestion", "summer", "sun", "support", "surprise", "sweet", "swim", "system", "table", "tail", "take", "talk", "tall", "taste", "tax", "teaching", "tendency", "test", "than", "then", "theory", "there", "thick", "thin", "thing", "though", "thought", "thread", "throat", "through", "thumb", "thunder", "ticket", "tight", "till", "time", "tin", "tired", "to", "together", "tomorrow", "tongue", "tooth", "top", "touch", "town", "trade", "train", "transport", "tray", "tree", "trick", "trouble", "trousers", "turn", "twist", "umbrella", "under", "unit", "up", "use", "value", "verse", "very", "vessel", "view", "violent", "voice", "waiting", "walk", "wall", "war", "warm", "wash", "waste", "watch", "water", "wave", "wax", "way", "weather", "week", "weight", "well", "west", "wet", "wheel", "when", "where", "while", "whip", "whistle", "white", "why", "wide", "will", "wind", "window", "wine", "wing", "winter", "wire", "wise", "with", "woman", "wood", "wool", "word", "work", "world", "worm", "wound", "writing", "wrong", "year", "yellow", "yes", "yesterday", "young" ]