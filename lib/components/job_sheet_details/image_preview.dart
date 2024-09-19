import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mech_manager/config/colors.dart';

class VehicleImagePreview extends StatefulWidget {
  int initialIndex;
  final List<String> imageUrls;
  final List<String> titles;

  VehicleImagePreview({
    super.key,
    required this.initialIndex,
    required this.imageUrls,
    required this.titles,
  });

  @override
  State<VehicleImagePreview> createState() => _VehicleImagePreviewState();
}

class _VehicleImagePreviewState extends State<VehicleImagePreview>
    with SingleTickerProviderStateMixin {
  TransformationController? controller;
  AnimationController? animationController;
  Animation<Matrix4>? animation;
  final double minScale = 1;
  final double maxScale = 4;
  double _scale = 1.0;
  double _previousscale = 1.0;
  double angle = 0.0;

  Map<int, double> imageScales = {};
  Map<int, double> imageAngles = {};

  @override
  void initState() {
    super.initState();
    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredImageUrls =
        widget.imageUrls.where((url) => url.isNotEmpty).toList();
    List<String> filteredTitles = widget.titles
        .where((t) => widget.imageUrls[widget.titles.indexOf(t)].isNotEmpty)
        .toList();

    if (filteredImageUrls.isEmpty) {}
    int currentIndex = widget.initialIndex % filteredImageUrls.length;
    bool showNavigationIcons = filteredImageUrls.length > 1;
    return Scaffold(
        backgroundColor: hintTextColor,
        body: LayoutBuilder(builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          final isMobile = screenWidth < 600;
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 70),
              child: Container(
                width: isMobile ? screenWidth * 0.9 : screenWidth * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: whiteColor,
                ),
                child: buildVehicleImagePreviewItem(
                  filteredImageUrls[currentIndex],
                  filteredTitles[currentIndex],
                  currentIndex,
                ),
              ),
            ),
          );
        }));
  }

  Widget buildVehicleImagePreviewItem(
      String imageUrl, String title, int initialIndex) {
    List<String> filteredImageUrls =
        widget.imageUrls.where((url) => url.isNotEmpty).toList();
    List<String> filteredTitles = widget.titles
        .where((t) => widget.imageUrls[widget.titles.indexOf(t)].isNotEmpty)
        .toList();

    if (filteredImageUrls.isEmpty)
      return SizedBox.shrink(); // Handle empty images

    int currentIndex = widget.initialIndex % filteredImageUrls.length;
    bool showNavigationIcons = filteredImageUrls.length > 1;

    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      final isMobile = screenWidth < 600;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Row 1: Title and Cancel button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: blackColor),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel_sharp,
                  size: 30,
                  color: blackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 2: Back button, Image, and Forward button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Back Button
              if (showNavigationIcons)
                GestureDetector(
                  onTap: () {
                    int newIndex =
                        (currentIndex - 1) % filteredImageUrls.length;
                    newIndex =
                        newIndex < 0 ? filteredImageUrls.length - 1 : newIndex;
                    setState(() {
                      widget.initialIndex = newIndex;
                      resetImageTransforms();
                    });
                  },
                  child: Container(
                    color: textfieldColor,
                    width: 40,
                    height: 40,
                    child: Center(
                        child: Icon(
                      Icons.chevron_left_outlined,
                      color: blackColor,
                      size: 30,
                    )),
                  ),
                ),

              // Image in Center
              Container(
                width: screenWidth * 0.6,
                height:
                    screenWidth * 0.6, // Keeping the image size proportional
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                child: GestureDetector(
                  onScaleStart: (ScaleStartDetails details) {
                    _previousscale = _scale;
                    setState(() {});
                  },
                  onScaleUpdate: (details) {
                    _scale = _previousscale * details.scale;
                    setState(() {});
                  },
                  onScaleEnd: (details) {
                    _previousscale = 1.0;
                    setState(() {});
                  },
                  child: InteractiveViewer(
                    transformationController: controller,
                    minScale: minScale,
                    maxScale: maxScale,
                    child: RotatedBox(
                      quarterTurns: (imageAngles[initialIndex] ?? 0) ~/ 90,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Hero(
                            tag: 'vehicle_image_$initialIndex',
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Forward Button
              if (showNavigationIcons)
                GestureDetector(
                  onTap: () {
                    int newIndex =
                        (currentIndex + 1) % filteredImageUrls.length;
                    setState(() {
                      widget.initialIndex = newIndex;
                      resetImageTransforms();
                    });
                  },
                  child: Container(
                    color: textfieldColor,
                    width: 40,
                    height: 40,
                    child: Center(
                        child: Icon(
                      Icons.chevron_right_outlined,
                      color: blackColor,
                      size: 30,
                    )),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                foregroundColor: blackColor,
                backgroundColor: primaryColor,
                heroTag: "zoomIn",
                mini: true,
                onPressed: () {
                  setState(() {
                    double currentScale = imageScales[initialIndex] ?? 1;
                    double newScale = currentScale + 0.1;
                    if (newScale <= maxScale) {
                      imageScales[initialIndex] = newScale;
                      controller?.value = Matrix4.identity()..scale(newScale);
                    }
                  });
                },
                child: const Icon(
                  Icons.zoom_in,
                  size: 19,
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                foregroundColor: blackColor,
                backgroundColor: primaryColor,
                heroTag: "zoomOut",
                mini: true,
                onPressed: () {
                  setState(() {
                    double currentScale = imageScales[initialIndex] ?? 1;
                    double newScale = currentScale - 0.1;
                    if (newScale >= minScale) {
                      imageScales[initialIndex] = newScale;
                      controller?.value = Matrix4.identity()..scale(newScale);
                    }
                  });
                },
                child: const Icon(
                  Icons.zoom_out,
                  size: 19,
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                foregroundColor: blackColor,
                backgroundColor: primaryColor,
                heroTag: "rotateAntiClockwise",
                mini: true,
                onPressed: () {
                  setState(() {
                    imageAngles[initialIndex] =
                        (imageAngles[initialIndex] ?? 0) - 90;
                    if (imageAngles[initialIndex]! % 360 == 0) {
                      imageAngles[initialIndex] = 0;
                    }
                  });
                },
                child: const Icon(
                  Icons.rotate_left,
                  size: 19,
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                foregroundColor: blackColor,
                backgroundColor: primaryColor,
                heroTag: "rotateClockwise",
                mini: true,
                onPressed: () {
                  setState(() {
                    imageAngles[initialIndex] =
                        (imageAngles[initialIndex] ?? 0) + 90;
                    if (imageAngles[initialIndex]! % 360 == 0) {
                      imageAngles[initialIndex] = 0;
                    }
                  });
                },
                child: const Icon(
                  Icons.rotate_right,
                  size: 21,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  void resetImageTransforms() {
    setState(() {
      controller?.value = Matrix4.identity();
      imageScales[widget.initialIndex] = 1.0;
      imageAngles[widget.initialIndex] = 0;
    });
  }
}



/*
  Widget buildVehicleImagePreviewItem(
      String imageUrl, String title, int initialIndex) {
    List<String> filteredImageUrls =
        widget.imageUrls.where((url) => url.isNotEmpty).toList();
    List<String> filteredTitles = widget.titles
        .where((t) => widget.imageUrls[widget.titles.indexOf(t)].isNotEmpty)
        .toList();

    if (filteredImageUrls.isEmpty) {}
    int currentIndex = widget.initialIndex % filteredImageUrls.length;
    bool showNavigationIcons = filteredImageUrls.length > 1;
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      final isMobile = screenWidth < 600;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: redColor),
              ),

              //cancle button
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 100,
                color: redColor,
                child: IconButton(
                  icon: Container(
                    color: lightGreyColor,
                    child: const Icon(
                      backarrow,
                      size: 27,
                    ),
                  ),
                  onPressed: () {
                    int newIndex =
                        (currentIndex - 1) % filteredImageUrls.length;
                    newIndex =
                        newIndex < 0 ? filteredImageUrls.length - 1 : newIndex;
                    setState(() {
                      widget.initialIndex = newIndex;
                      resetImageTransforms();
                    });
                  },
                ),
              ),
              Container(
                width: 400,
                height: 400,
                child: GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      imageScales[initialIndex] = 1.0;
                      controller?.value = Matrix4.identity();
                    });
                  },
                  onScaleStart: (ScaleStartDetails details) {
                    _previousscale = _scale;
                    setState(() {});
                  },
                  onScaleUpdate: (details) {
                    _scale = _previousscale * details.scale;
                    setState(() {});
                  },
                  onScaleEnd: (details) {
                    _previousscale = 1.0;
                    setState(() {});
                  },
                  child: Transform.scale(
                    scale: imageScales[initialIndex] ?? 1.0,
                    child: InteractiveViewer(
                      clipBehavior: Clip.none,
                      transformationController: controller,
                      panEnabled: false,
                      minScale: minScale,
                      maxScale: maxScale,
                      // onInteractionEnd: (details) {
                      //   resetAnimation();
                      // },
                      child: RotatedBox(
                        quarterTurns: (imageAngles[initialIndex] ?? 0) ~/ 90,
                        child: Container(
                          //for image height width
                          height: 380,
                          width: 400,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl, //image url
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                color: redColor,
                child: IconButton(
                  icon: Container(
                    color: lightGreyColor,
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 27,
                    ),
                  ),
                  onPressed: () {
                    int newIndex =
                        (currentIndex + 1) % filteredImageUrls.length;
                    setState(() {
                      widget.initialIndex = newIndex;
                      resetImageTransforms();
                    });
                  },
                ),
              ),
            ],
          ),
          /*
          Stack(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    imageScales[initialIndex] = 1.0;
                    controller?.value = Matrix4.identity();
                  });
                },
                onScaleStart: (ScaleStartDetails details) {
                  _previousscale = _scale;
                  setState(() {});
                },
                onScaleUpdate: (details) {
                  _scale = _previousscale * details.scale;
                  setState(() {});
                },
                onScaleEnd: (details) {
                  _previousscale = 1.0;
                  setState(() {});
                },
                child: Transform.scale(
                  scale: imageScales[initialIndex] ?? 1.0,
                  child: InteractiveViewer(
                    clipBehavior: Clip.none,
                    transformationController: controller,
                    panEnabled: false,
                    minScale: minScale,
                    maxScale: maxScale,
                    // onInteractionEnd: (details) {
                    //   resetAnimation();
                    // },
                    child: RotatedBox(
                      quarterTurns: (imageAngles[initialIndex] ?? 0) ~/ 90,
                      child: Container(
                        //for image height width
                        height: 380,
                        width: 400,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl, //image url
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          */
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          //floating button bottoms
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                foregroundColor: blackColor,
                backgroundColor: primaryColor,
                heroTag: "zoomIn",
                mini: true,
                onPressed: () {
                  setState(() {
                    double currentScale = imageScales[initialIndex] ?? 1;
                    double newScale = currentScale + 0.1;
                    if (newScale <= maxScale) {
                      imageScales[initialIndex] = newScale;
                      controller?.value = Matrix4.identity()..scale(newScale);
                    }
                  });
                },
                child: const Icon(
                  Icons.zoom_in,
                  size: 19,
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                foregroundColor: blackColor,
                backgroundColor: primaryColor,
                heroTag: "zoomOut",
                mini: true,
                onPressed: () {
                  setState(() {
                    double currentScale = imageScales[initialIndex] ?? 1;
                    double newScale = currentScale - 0.1;
                    if (newScale >= minScale) {
                      imageScales[initialIndex] = newScale;
                      controller?.value = Matrix4.identity()..scale(newScale);
                    }
                  });
                },
                child: const Icon(
                  Icons.zoom_out,
                  size: 19,
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                foregroundColor: blackColor,
                backgroundColor: primaryColor,
                heroTag: "rotateAntiClockwise",
                mini: true,
                onPressed: () {
                  setState(() {
                    imageAngles[initialIndex] =
                        (imageAngles[initialIndex] ?? 0) - 90;
                    if (imageAngles[initialIndex]! % 360 == 0) {
                      imageAngles[initialIndex] = 0;
                    }
                  });
                },
                child: const Icon(
                  Icons.rotate_left,
                  size: 19,
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                foregroundColor: blackColor,
                backgroundColor: primaryColor,
                heroTag: "rotateClockwise",
                mini: true,
                onPressed: () {
                  setState(() {
                    imageAngles[initialIndex] =
                        (imageAngles[initialIndex] ?? 0) + 90;
                    if (imageAngles[initialIndex]! % 360 == 0) {
                      imageAngles[initialIndex] = 0;
                    }
                  });
                },
                child: const Icon(
                  Icons.rotate_right,
                  size: 21,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      );
    });
  }

  */
